//
//  DocumentMenuAction.swift
//  Smado
//
//  Created by Sergei Volkov on 02.07.2022.
//

import SwiftUI

struct DocumentMenuAction: View {
    
    @StateObject var doc: DocumentCD
    let width: CGFloat
    let editAction: ()->()
    
    @State private var imageUrls = [URL]()
    @State private var selectedUrl: URL?
    
    var body: some View {
        
        Menu {
            Button {
                prepareImageForPreview(doc: doc)
            } label: {
                Label("Show", systemImage: "photo")
            }
            Button {
                editAction()
            } label: {
                Label("Edit", systemImage: "square.and.pencil")
            }
        } label: {
            DocumentsGridCellView(doc: doc, cellWidth: width) {}
        }
        .foregroundColor(.primary)
        
        .quickLookPreview($selectedUrl, in: imageUrls)
    }
    
}

extension DocumentMenuAction {
    
    fileprivate func prepareImageForPreview(doc: DocumentCD) {
        selectedUrl = nil
        imageUrls = []
        
        doc.unwrapImages.forEach { image in
            if let data = image.data,
               let fileName = image.fileName,
               let url = LocalFilesHelper.writeTempFile(data: data, fileName: fileName)
            {
                imageUrls.append(url)
            }
        }
        selectedUrl = imageUrls.first
    }
    
}
