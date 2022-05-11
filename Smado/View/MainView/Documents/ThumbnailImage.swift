//
//  ThumbnailImage.swift
//  Smado
//
//  Created by Sergei Volkov on 12.05.2022.
//

import SwiftUI

struct ThumbnailImage: View {
    
    let uiImage: UIImage
    let imageFrame: CGFloat
    
    var body: some View {
        Image(uiImage: uiImage)
            .resizable()
            .scaledToFill()
            .frame(width: imageFrame, height: imageFrame, alignment: .center)
            .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 6, style: .continuous)
                    .stroke(Color("imageFrameColor"), lineWidth: 2)
            )
    }
}
