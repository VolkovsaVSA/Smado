//
//  MenuFileButton.swift
//  Smado
//
//  Created by Sergei Volkov on 20.03.2022.
//

import SwiftUI

struct MenuFileButton: View {
    
    @Binding var switcher: Bool
    let label: String
    let systemImage: String
    
    var body: some View {
        Button {
            switcher.toggle()
        } label: {
            Label(label, systemImage: systemImage)
        }
    }
}

