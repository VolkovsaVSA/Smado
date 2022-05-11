//
//  CameraPicker.swift
//  Smado
//
//  Created by Sergei Volkov on 20.03.2022.
//

import UIKit
import SwiftUI

struct CameraPicker: UIViewControllerRepresentable {
    
    @Environment(\.dismiss) private var dismiss
    @Binding var selectedFile: FileModel?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.cameraCaptureMode = .photo

        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var picker: CameraPicker
        
        init(picker: CameraPicker) {
            self.picker = picker
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            guard let image = info[.originalImage] as? UIImage else {return}
            let imageName = Date().formatted(date: .numeric, time: .standard)
                .replacingOccurrences(of: ".", with: "_")
                .replacingOccurrences(of: ",", with: "_")
                .replacingOccurrences(of: "/", with: "_")
                .replacingOccurrences(of: ":", with: "_")
                .replacingOccurrences(of: " ", with: "_")
            
            UIGraphicsBeginImageContext(image.size)
            image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
            guard let rotateImage = UIGraphicsGetImageFromCurrentImageContext() else {return}
            UIGraphicsEndImageContext()
            
            
            if let imageData = rotateImage.pngData(),
               let comressedData = ImageHelper.compressImageWithData(data: imageData)
            {
                DispatchQueue(label: Queue.smadoCameraImageQueue.rawValue).sync {
                    self.picker.selectedFile = FileModel(data: comressedData, fileName: imageName)
                }
            }

            self.picker.dismiss()
        }
        
    }
    
}
