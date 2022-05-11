//
//  EmptyDocImage.swift
//  Smado
//
//  Created by Sergei Volkov on 12.04.2022.
//

import SwiftUI

struct EmptyThumbnail: View {
    
    private let imageFrame: CGFloat
    private let frameWidth: CGFloat
    
    init(cellWidth: CGFloat) {
        self.frameWidth = cellWidth
        self.imageFrame = CGFloat(Int(cellWidth / 3.3))
    }
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: 6, style: .continuous).stroke(Color("imageFrameColor"), lineWidth: 2)
            .background(Color.primary.colorInvert())
            .frame(width: imageFrame, height: imageFrame, alignment: .center)
            .overlay(
                Image(systemName: "eye.slash")
                    .foregroundColor(Color("imageFrameColor"))
            )
        
        
    }
}
