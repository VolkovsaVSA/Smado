//
//  GradientLine.swift
//  Smado
//
//  Created by Sergei Volkov on 21.04.2022.
//

import SwiftUI

struct GradientLine: View {
    var body: some View {
        LinearGradient(colors: [Color(UIColor.tertiarySystemBackground), .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
            .frame(height: 12)
    }
}

