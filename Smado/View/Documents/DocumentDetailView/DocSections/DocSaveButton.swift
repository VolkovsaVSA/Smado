//
//  DocSaveButton.swift
//  Smado
//
//  Created by Sergei Volkov on 21.04.2022.
//

import SwiftUI

struct DocSaveButton: View {
    
    @Binding var title: String
    let isNewDocument: Bool
    
    let action: ()->()
    
    var body: some View {
        
        VStack {
            Spacer()
            Button {
                action()
            } label: {
                Text(isNewDocument ? "Create" : "Save")
                    .font(.title2)
                    .frame(width: UIScreen.main.bounds.width / 1.5)
            }
            .buttonStyle(.borderedProminent)
            .tint(isNewDocument ? .red : .blue)
            .disabled(title.isEmpty)
            .padding(.bottom)
        }
        .ignoresSafeArea(.keyboard, edges: .all)
        
        
    }
}

