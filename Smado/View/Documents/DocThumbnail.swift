//
//  DocThumbnail.swift
//  Smado
//
//  Created by Sergei Volkov on 12.04.2022.
//

import SwiftUI

struct DocThumbnail: View {
    
    private let frameWidth: CGFloat
    private let imageFrame: CGFloat
    private let image: ImageCD
    
    init(image: ImageCD, cellWidth: CGFloat) {
        self.frameWidth = cellWidth
        self.imageFrame = CGFloat(Int(cellWidth / 3.3))
        self.image = image
    }
    
    var body: some View {
        
        if image.fileExtention?.lowercased() == "pdf" {
            if let data = image.data,
                let uiImage = ImageHelper.drawPDFfromData(data: data as CFData)
            
            {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: imageFrame, height: imageFrame, alignment: .center)
                    .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 6, style: .continuous)
                            .stroke(Color("imageFrameColor"), lineWidth: 2)
                    )
            } else {
                EmptyThumbnail(cellWidth: frameWidth)
            }
        } else {
            if let data = image.data,
               let uiImage = UIImage(data: data)
            {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: imageFrame, height: imageFrame, alignment: .center)
                    .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 6, style: .continuous)
                            .stroke(Color("imageFrameColor"), lineWidth: 2)
                    )
            } else {
                EmptyThumbnail(cellWidth: frameWidth)
            }
        }
        
        
    }
}
