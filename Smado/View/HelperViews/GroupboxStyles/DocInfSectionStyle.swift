//
//  DocInfSectionStyle.swift
//  Smado
//
//  Created by Sergei Volkov on 19.05.2022.
//

import SwiftUI


struct DocInfSectionStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            configuration.label
            configuration.content
        }
        .padding()
        .background(
            Color(UIColor.tertiarySystemBackground)
                .cornerRadius(12)
                .modifier(CellShadowModifire())
        )
    }
}
