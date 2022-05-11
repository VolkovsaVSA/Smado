//
//  IconView.swift
//  Buman
//
//  Created by Sergey Volkov on 16.06.2020.
//  Copyright © 2020 Sergei Volkov. All rights reserved.
//

import SwiftUI

struct IconButton: View {
    
    let icon: String
    @Binding var selectedIcon: String
    var size: CGFloat
    
    var body: some View {
        
        Button(action: {
            withAnimation(.interactiveSpring()) {
                selectedIcon = icon
            }
        }) {
            Icon(icon: icon, size: size)
        }
        
    }
}
