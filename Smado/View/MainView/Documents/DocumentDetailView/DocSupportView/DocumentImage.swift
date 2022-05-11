//
//  DocumentImage.swift
//  Smado
//
//  Created by Sergei Volkov on 27.03.2022.
//

import SwiftUI
import PDFKit

struct DocumentImage: View {
    
    let image: ImageCD
    
    init(image: ImageCD) {
        self.image = image
    }
    
    var body: some View {
        
        if let data = image.data,
           let uiImage = UIImage(data: data)
        {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
                .cornerRadius(12)
        } else {
            Image(systemName: "eye.slash")
                .resizable()
                .scaledToFit()
                .foregroundColor(Color("imageFrameColor"))
            
        }
    }
}


