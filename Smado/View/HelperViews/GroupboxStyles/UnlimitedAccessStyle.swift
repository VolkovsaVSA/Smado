//
//  UnlimitedAccessStyle.swift
//  Smado
//
//  Created by Sergei Volkov on 22.05.2022.
//

import SwiftUI

struct UnlimitedAccessStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .center, spacing: 6) {
            configuration.label
            configuration.content
        }
        .padding()
        .background(
            Color.green.opacity(0.5).cornerRadius(20)
        )
    }
}
