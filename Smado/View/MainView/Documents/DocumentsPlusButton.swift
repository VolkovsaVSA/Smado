//
//  DocumentsPlusButton.swift
//  Smado
//
//  Created by Sergei Volkov on 04.04.2022.
//

import SwiftUI

struct DocumentsPlusButton: View {
    
    let action: ()->()
    
    var body: some View {
        
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button {
                    action()
                } label: {
                    Image(systemName: "doc.badge.plus")
                        .foregroundColor(.white)
                        .font(.system(size: 24, weight: .semibold, design: .default))
                        .padding(10)
                        .background(
                            Circle()
                                .shadow(color: .black.opacity(0.3), radius: 6, x: 2, y: 2)
                        )
                        .overlay(
                            Circle().stroke(Color.white, lineWidth: 2)
                        )
        
                }
            }
        }
        .padding(.trailing, 16)
        .padding(.bottom, 16)
    }
    
}

