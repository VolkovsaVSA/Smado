//
//  ColorView.swift
//
//  Created by Sergey Volkov on 16.06.2020.
//  Copyright © 2020 Sergei Volkov. All rights reserved.
//

import SwiftUI

struct ColorView: View {
    
    var color: Color
    @Binding var selected: Color
    var size: CGFloat
    
    var body: some View {
        
        Button(action: {
            selected = color
        }) {
            LinearGradient(gradient: Gradient(colors: [color.opacity(0.5), color]), startPoint: .top, endPoint: .bottom)
                .frame(width: self.size, height: self.size)
                .clipShape(Circle())
        }
        
    }
}
