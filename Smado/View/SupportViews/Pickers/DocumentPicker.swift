//
//  DocumentPicker.swift
//  Smado
//
//  Created by Sergei Volkov on 14.05.2022.
//

import SwiftUI

struct DocumentPicker: UIViewControllerRepresentable {
    
    @Binding var files: [FileModel]
    @Binding var bigFiles: String
    
    func makeCoordinator() -> DocumentPicker.Coordinator {
        return DocumentPicker.Coordinator(parent: self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<DocumentPicker>) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: [.image, .pdf], asCopy: true)
        picker.allowsMultipleSelection = true
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: DocumentPicker.UIViewControllerType, context: UIViewControllerRepresentableContext<DocumentPicker>) {
    }
    
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        
        var parent: DocumentPicker
        
        init(parent: DocumentPicker){
            self.parent = parent
        }
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            var tempBigFiles = [(String, Int)]()
            
            urls.forEach { url in
                print(url)
                if url.pathExtension.lowercased() == "pdf" {
                    guard let data = FileManager.default.contents(atPath: url.path) else { return }
                    if data.count > 4_000_000 {
                        print("\(url.lastPathComponent): \(data.count)")
                        tempBigFiles.append((url.lastPathComponent,data.count))
                    } else {
                        parent.$files.wrappedValue.append(FileModel(data: data, fileName: url.lastPathComponent))
                    }
                } else {
                    guard let data = ImageHelper.compressImageWithURL(url: url) else { return }
                    parent.$files.wrappedValue.append(FileModel(data: data, fileName: url.lastPathComponent))
                }
            }
            
            if !tempBigFiles.isEmpty {
                parent.bigFiles = ""
                tempBigFiles.forEach { file in
                    parent.bigFiles += file.0 + " (\(file.1/1_000_000) MB)" + "\n"
                }
            }
            
        }
        
    }
}

