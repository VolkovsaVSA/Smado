//
//  DocImageView.swift
//  Smado
//
//  Created by Sergei Volkov on 29.06.2022.
//

import SwiftUI

struct DocImageView: View {
    private var height: CGFloat { UIScreen.main.bounds.width / 0.8 }
    @State var image: ImageCD
    
    var body: some View {
        if image.fileExtention?.lowercased() == "pdf" {
            if let data = image.data {
                PDFKitView(data: data, singlePage: false)
                    .frame(height: height)
            } else {
                Image(systemName: "eye.slash")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color("imageFrameColor"))
            }
        } else {
            DocumentImage(image: image)
        }
    }
}
