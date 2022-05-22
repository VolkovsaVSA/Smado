//
//  FileDetailView.swift
//  Smado
//
//  Created by Sergei Volkov on 26.03.2022.
//

import SwiftUI

struct DocumentDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \CategoryCD.craetedDate, ascending: true)],
        animation: .default)
    private var categories: FetchedResults<CategoryCD>
    @State private var columns = [GridItem(.adaptive(minimum: UIDevice.isIPad ? UIScreen.main.bounds.width * 0.17 : UIScreen.main.bounds.width * 0.3))]
    private var height: CGFloat { UIScreen.main.bounds.width / 0.75 }
    
    @State private var showCameraPicker = false
    @State private var showImagePicker = false
    @State private var showDocumentPicker = false
    @State private var cameraSelectedFile: FileModel?
    @State private var files: [FileModel] = []
    @State private var refreshFilesID = UUID()
    @State private var showDeleteAlert = false
    @State private var showBigFilesAlert = false
    @State private var bigFiles: String = ""
    @State private var tempUrl: URL? = nil
    @State private var tooManySeletedFilesAlert = false
    @State private var tooManyImagesAlert = false

    @State private var category: CategoryCD? = nil
    @State private var document: DocumentCD? = nil
    @State private var title: String
    @State private var dateEnd: Date
    @State private var notifToday: Bool
    @State private var notifWeek: Bool
    @State private var notifMonth: Bool
    @State private var isNewDocument: Bool
    
    init(document: DocumentCD, isNewDocument: Bool) {
        _document = State(initialValue: document)
        _title = State(initialValue: document.title ?? "")
        _dateEnd = State(initialValue: document.dateEnd ?? Date())
        _notifToday = State(initialValue: document.notifToday)
        _notifWeek = State(initialValue: document.notifWeek)
        _notifMonth = State(initialValue: document.notifMonth)
        _category = State(initialValue: document.parentCategory)
        _isNewDocument = State(initialValue: isNewDocument)
    }
    
    var body: some View {
        
        NavigationView {
            
            List {
                DocDataSection(title: $title, dateEnd: $dateEnd, category: $category)
                DocNotifSection(notifToday: $notifToday, notifWeek: $notifWeek, notifMonth: $notifMonth)
                DocFilesSection(document: $document)
            }
            .overlay(
                DocSaveButton(title: $title, isNewDocument: isNewDocument) { docSaveAction() }
            )
            .listStyle(.plain)
            .background(colorScheme == .dark ? Color.black.opacity(0.2) : .white)
            .onAppear {
              UITableView.appearance().backgroundColor = .clear
            }
            .onDisappear {
              UITableView.appearance().backgroundColor = .systemGroupedBackground
            }
            
            
            
            .toolbar {
                toolbarButton()
            }
            .navigationTitle("Edit")
        }
        .interactiveDismissDisabled(true)
        
        .sheet(isPresented: $showCameraPicker) {
            CameraPicker(selectedFile: $cameraSelectedFile)
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(files: $files, selectionLimit: AccessLimits.maxSelectedFiles)
        }
//        .documentPicker(isPresented: $showDocumentPicker, files: $files) { tempBigFiles in
//            bigfilesProcessing(tempBigFiles)
//        }
        .sheet(isPresented: $showDocumentPicker) {
            
            DocumentPicker(files: $files,
                           bigFiles: $bigFiles,
                           maxFileSizeBytes: AccessLimits.maxFileSizeBytes,
                           maxSelectedFiles: AccessLimits.maxSelectedFiles)
            { tooManyFiles in
                if tooManyFiles {
                    tooManySeletedFilesAlert.toggle()
                }
            }
        }
        
        .onChange(of: cameraSelectedFile) {
            onChangeCameraFile($0)
        }
        .onChange(of: files) {
            onChangeFile($0)
        }
        .onChange(of: bigFiles, perform: { newValue in
            showBigFilesAlert.toggle()
        })

        .alert("Delete this document?", isPresented: $showDeleteAlert) {
            Button("Delete", role: .destructive) {
                deleteAlertAction()
            }
        }
        .alert("Warning!", isPresented: $showBigFilesAlert) {
            //default action
        } message: {
            Text("These files are too big (over \(AccessLimits.maxFileSizeBytes.formatted(.byteCount(style: .file, allowedUnits: .mb, spellsOutZero: false, includesActualByteCount: false)))): \n\n\(bigFiles)\nPlease reduce the file size, convert to image format, or choose other files.")
        }
        .alert("Warning!", isPresented: $tooManySeletedFilesAlert) {
            
        } message: {
            Text("Too many files have been selected. The maximum number of selected files is 5!")
        }
        .alert("Warning!", isPresented: $tooManyImagesAlert) {
            
        } message: {
            Text("Too many images saved! Maximum number of files to save: \(AccessLimits.maxSelectedFiles)")
        }

        
    }
}


extension DocumentDetailView {
        
    fileprivate func docSaveAction() {
        if let document = document {
            document.title = title.trimmingCharacters(in: .whitespaces)
            document.dateEnd = dateEnd
            document.notifToday = notifToday
            document.notifWeek = notifWeek
            document.notifMonth = notifMonth
            document.parentCategory = category
            CDStack.shared.saveContext(context: viewContext)
        }
        dismiss()
    }
    
    fileprivate func deleteAlertAction() {
        withAnimation {
            if let doc = document {
                viewContext.delete(doc)
                CDStack.shared.saveContext(context: viewContext)
                dismiss()
            }
        }
    }
    
    fileprivate func onChangeFile(_ newValue: [FileModel]) {
        
        newValue.forEach { file in
            if let doc = document {
                if CDStack.shared.fetchImages().count < AccessLimits.maxStoredFiles || AccessLimits.maxStoredFiles == 0 {
                    _ = CDStack.shared.createImage(document: doc, fileName: file.fileName, data: file.data)
                } else {
                    tooManyImagesAlert = true
                }
            }
        }
 
        files = []
    }
    
    fileprivate func onChangeCameraFile(_ newValue: FileModel?) {
        if let newfile = newValue { files.append(newfile) }
    }
    
    
    @ToolbarContentBuilder
    private func toolbarButton() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            HStack(spacing: 20) {
                
                if !isNewDocument {
                    Button(role: .destructive) {
                        showDeleteAlert.toggle()
                    } label: {
                        Image(systemName: "trash")
                    }
                    .foregroundColor(.red)
                }
                
                Menu {
                    MenuFileButton(switcher: $showCameraPicker, label: "Camera", systemImage: "camera")
                    MenuFileButton(switcher: $showImagePicker, label: "Photo", systemImage: "photo.on.rectangle.angled")
                    MenuFileButton(switcher: $showDocumentPicker, label: "File", systemImage: "doc")
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 14, weight: .bold, design: .default))
                        .padding(6)
                        .background(.quaternary)
                        .cornerRadius(8)
                }
                .buttonStyle(.bordered)
            }
            
        }
        ToolbarItem(placement: .navigationBarLeading) {
            Button("Cancel", role: .destructive) {
                viewContext.rollback()
                dismiss()
            }
            .foregroundColor(.red)
        }
    }
    
}
