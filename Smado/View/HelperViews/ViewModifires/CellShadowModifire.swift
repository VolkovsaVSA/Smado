//
//  CellShadowModifire.swift
//  Smado
//
//  Created by Sergei Volkov on 24.05.2022.
//

import SwiftUI

struct CellShadowModifire: ViewModifier {
 
    @Environment(\.colorScheme) var colorScheme
   
    func body(content: Content) -> some View {
        content
            .shadow(color: colorScheme == .dark ? .clear : .black.opacity(0.2), radius: 6, x: 0, y: 3)
    }
}
