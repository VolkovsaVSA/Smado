//
//  SettingsIcon.swift
//  Smado
//
//  Created by Sergei Volkov on 21.04.2022.
//

import SwiftUI

struct SettingsIcon: View {
    
    let systemName: String
    let color: Color
    
    var body: some View {
        Image(systemName: systemName)
            .frame(width: 28, height: 28)
            .foregroundColor(.white)
            .background(
                RoundedRectangle(cornerRadius: 6, style: .circular)
                    .fill(
                        LinearGradient(colors: [color.opacity(0.3), color],
                                       startPoint: .topLeading,
                                       endPoint: .bottomTrailing)
                    )
            )
    }
}
