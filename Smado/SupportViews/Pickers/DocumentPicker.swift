//import Foundation
//import SwiftUI
//import PDFKit
////import Compression
//
//struct DocumentPicker: UIViewControllerRepresentable {
//    
//    @Binding var files: [FileModel]
//    
//    func makeCoordinator() -> Coordinator {
//        return Coordinator(self)
//    }
//    
//    func makeUIViewController(context: UIViewControllerRepresentableContext<DocumentPicker>) -> UIDocumentPickerViewController {
//        let picker = UIDocumentPickerViewController(forOpeningContentTypes: [.image, .pdf], asCopy: true)
//        picker.allowsMultipleSelection = true
//        picker.shouldShowFileExtensions = true
//        picker.isEditing = false
//        picker.delegate = context.coordinator
//        return picker
//    }
//    
//    func updateUIViewController(_ uiViewController: DocumentPicker.UIViewControllerType, context: UIViewControllerRepresentableContext<DocumentPicker>) {
//        
//    }
//    
//    class Coordinator: NSObject, UIDocumentPickerDelegate {
//        
//        var parent: DocumentPicker
//        
//        init(_ parent: DocumentPicker) {
//            self.parent = parent
//        }
//        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
//        
//            urls.forEach { url in
//                if url.pathExtension.lowercased() == "pdf" {
//                    guard let data = FileManager.default.contents(atPath: url.path) else { return }
//                    parent.files.append(FileModel(data: data, fileName: url.lastPathComponent))
//                } else {
//                    guard let data = ImageHelper.compressImageWithURL(url: url) else {return}
//                    parent.files.append(FileModel(data: data, fileName: url.lastPathComponent))
//                }
//            }
//            
//        }
//        
//        
//    }
//}
