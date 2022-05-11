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
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \CategoryCD.craetedDate, ascending: true)],
        animation: .default)
    private var categories: FetchedResults<CategoryCD>
    @State private var columns = [GridItem(.adaptive(minimum: UIDevice.isIPad ? UIScreen.main.bounds.width * 0.17 : UIScreen.main.bounds.width * 0.3))]
    
    @State private var showCameraPicker = false
    @State private var showImagePicker = false
    @State private var showDocumentPicker = false
    @State private var cameraSelectedFile: FileModel?
    @State private var files: [FileModel] = []
    @State private var refreshfilesID = UUID()
    @State private var showDeleteAlert = false

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
            
            ZStack {
                List {
                    DocDataSection(title: $title, dateEnd: $dateEnd, category: $category)
                        .listRowBackground(Color.primary.colorInvert())
                    DocNotifSection(notifToday: $notifToday, notifWeek: $notifWeek, notifMonth: $notifMonth)
                        .listRowBackground(Color.primary.colorInvert())
                    DocFilesSection(document: $document)
                        .listRowBackground(Color.primary.colorInvert())
                }
                .background(Color.primary.colorInvert())
                .font(.system(size: 15, weight: .light, design: .default))
                .listStyle(.plain)
                
                DocSaveButton(title: $title, isNewDocument: isNewDocument) { docSaveAction() }
            }
            .toolbar { toolbarButton() }
            .navigationBarTitleDisplayMode(.inline)
        }
        .interactiveDismissDisabled(true)
        
        .sheet(isPresented: $showCameraPicker) { CameraPicker(selectedFile: $cameraSelectedFile) }
        .sheet(isPresented: $showImagePicker) { ImagePicker(files: $files) }
        .documentPicker(isPresented: $showDocumentPicker, files: $files)

        .onChange(of: cameraSelectedFile) { onChangeCameraFile($0) }
        .onChange(of: files) { onChangeFile($0) }
 
        .alert("Delete this document?", isPresented: $showDeleteAlert) {
            Button("Delete", role: .destructive) { deleteAlertAction() }
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
                _ = CDStack.shared.createImage(document: doc, fileName: file.fileName, data: file.data)
            }
        }
        files = []
        refreshfilesID = UUID()
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
        ToolbarItem(placement: .principal) {
            if let files = document?.images
            {
                Text("Files (\(files.count.description))")
                    .font(.system(size: 14, weight: .thin, design: .default))
            }
        }
        
    }
    
}