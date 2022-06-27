//
//  Developer.swift
//  Smado
//
//  Created by Sergei Volkov on 28.06.2022.
//

import SwiftUI

struct Developer: View {
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var images: FetchedResults<ImageCD>
    
    
    var body: some View {
        
        List(images) { image in
            VStack {
                HStack {
                    Text("fileName: ")
                    Text(image.fileName ?? "nil")
                }
                HStack {
                    Text("fileExtention: ")
                    Text(image.fileExtention ?? "nil")
                }
            }
        }
        
    }
}
