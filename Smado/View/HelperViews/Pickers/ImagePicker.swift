//
//  ImagePicker.swift
//  Debts
//
//  Created by Sergei Volkov on 06.12.2021.
//

import PhotosUI
import SwiftUI
import UniformTypeIdentifiers


struct ImagePicker: UIViewControllerRepresentable {

    @Binding var files: [FileModel]
    let selectionLimit: Int
     
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = selectionLimit
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) { }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            for result in results {
                
                result.itemProvider.loadFileRepresentation(forTypeIdentifier: UTType.image.identifier) { (url, error) in

                    guard let localUrl = url else {return}
                    let dispatchQueue = DispatchQueue(label: Queue.smadoAlbumImageQueue.rawValue)
                    
                    dispatchQueue.sync {
                        guard let data = ImageHelper.compressImageWithURL(url: localUrl) else { return }
                        
                        if self.parent.files.contains(where: { item in
                            item.fileName == localUrl.lastPathComponent
                        }) {
                            var newFileName = conversionFileName(lastPathComponent: localUrl.lastPathComponent)
//
                            if self.parent.files.contains(where: { item in
                                item.fileName == newFileName
                            }) { newFileName = conversionFileName(lastPathComponent: newFileName) }

                            let file = FileModel(data: data, fileName: newFileName)
                            self.parent.files.append(file)
                            
                        } else {
                            let file = FileModel(data: data, fileName: localUrl.lastPathComponent)
                            self.parent.files.append(file)
                        }
                        
                    }
                    
                }
                
            }

            
        }
        
    }
    
    static func conversionFileName(lastPathComponent: String) -> String {
        var newFileName = ""
        
        if let fileName = lastPathComponent.components(separatedBy: ".").dropLast().first {
            let dateString = Date().formatted(date: .numeric, time: .omitted)
            let dateSeparated = dateString.components(separatedBy: "/")
            var dateChapter = ""
            dateSeparated.forEach { item in
                dateChapter += "_" + item
            }
            newFileName = fileName + dateChapter
            if let extention = lastPathComponent.components(separatedBy: ".").last {
                newFileName += "." + extention
            }
        }
        
        return newFileName
    }
    
    
    
}
