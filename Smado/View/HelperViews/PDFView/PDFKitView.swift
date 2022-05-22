//
//  PDFKitView.swift
//  Smado
//
//  Created by Sergei Volkov on 04.05.2022.
//

import SwiftUI
import PDFKit

struct PDFKitView: UIViewRepresentable {
    typealias UIViewType = PDFView

    let data: Data
    let singlePage: Bool
    
    @State private var height: CGFloat = 50

    func makeUIView(context _: UIViewRepresentableContext<PDFKitView>) -> UIViewType {
        // Create a `PDFView` and set its `PDFDocument`.
        let pdfView = PDFView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        pdfView.document = PDFDocument(data: data)
//        let pageBounds = pdfView.document?.page(at: 0)?.bounds(for: pdfView.displayBox)
//        print(pageBounds)
//        pdfView.usePageViewController(true, withViewOptions: nil)
        pdfView.autoScales = true
        pdfView.backgroundColor = .clear
        
        if singlePage {
            pdfView.displayMode = .singlePage
        }
        return pdfView
    }

    func updateUIView(_ pdfView: UIViewType, context _: UIViewRepresentableContext<PDFKitView>) {
        pdfView.document = PDFDocument(data: data)
        pdfView.usePageViewController(true, withViewOptions: nil)
    }
}
