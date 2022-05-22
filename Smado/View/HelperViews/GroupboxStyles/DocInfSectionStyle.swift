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
                .shadow(color: Color.shadowColor, radius: 6, x: 0, y: 3)
        )
    }
}
