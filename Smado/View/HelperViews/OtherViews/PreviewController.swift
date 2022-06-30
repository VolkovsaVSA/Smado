//
//  PreviewController.swift
//  Smado
//
//  Created by Sergei Volkov on 22.05.2022.
//

import SwiftUI
import QuickLook

struct PreviewController: UIViewControllerRepresentable {
    @Binding var url: URL?
    let isEditing: Bool
    
    func makeUIViewController(context: Context) -> UINavigationController {
        let controller = QLPreviewController()
        controller.isEditing = isEditing
        controller.dataSource = context.coordinator
        controller.delegate = context.coordinator
        let navigationController = UINavigationController(rootViewController: controller)
        return navigationController
//        return controller
    }
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    class Coordinator: NSObject, QLPreviewControllerDelegate, QLPreviewControllerDataSource {
        let parent: PreviewController
        init(parent: PreviewController) {
            self.parent = parent
        }
        func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
            return 1
        }
        func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
            guard let url  = parent.url as? NSURL else {
                return URL(fileURLWithPath: "") as QLPreviewItem
                
            }
            print(url)
            return url
        }
        func previewController(_ controller: QLPreviewController, editingModeFor previewItem: QLPreviewItem) -> QLPreviewItemEditingMode {
            return .updateContents
        }
        func previewController(_: QLPreviewController, didSaveEditedCopyOf: QLPreviewItem, at: URL) {
            print("Saved: " + at.path)
            parent.url = at
        }
    }
}
