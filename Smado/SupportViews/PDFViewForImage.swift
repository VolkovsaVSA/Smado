//
//  PhotoDetailView.swift
//  Smado
//
//  Created by Sergei Volkov on 31.03.2022.
//

import SwiftUI
import PDFKit

struct PDFViewForImage: UIViewRepresentable {
    @Environment(\.dismiss) private var dismiss
    
    let image: UIImage

    func makeUIView(context: Context) -> PDFView {
        let view = PDFView()
        view.document = PDFDocument()
        guard let page = PDFPage(image: image) else { return view }
        view.document?.insert(page, at: 0)
//        view.autoScales = true
        view.scalesLargeContentImage = true
        return view
    }

    func updateUIView(_ uiView: PDFView, context: Context) { }
}
