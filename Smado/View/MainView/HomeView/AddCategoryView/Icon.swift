//
//  Icon.swift
//  Smado
//
//  Created by Sergei Volkov on 12.04.2022.
//

import SwiftUI

struct Icon: View {
    @Environment(\.colorScheme) private var colorScheme
    
    let icon: String
    let size: CGFloat
    
    init(icon: String, size: CGFloat) {
        self.icon = icon
        self.size = size
    }
    
    var body: some View {
        Image(systemName: icon)
            .resizable()
            .scaledToFit()
            .padding(UIDevice.isIPhone ? 12 : 16)
            .frame(width: self.size, height: self.size)
            .foregroundColor(.blue.opacity(0.9))
            .background(
                Color(UIColor.tertiarySystemBackground)
                    .cornerRadius(12)
                    .modifier(CellShadowModifire())
            )
    }
}

