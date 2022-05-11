//
//  SettingsButton.swift
//  Smado
//
//  Created by Sergei Volkov on 29.04.2022.
//

import SwiftUI

struct SettingsButton: View {
    
    let action: ()->()
    
    var body: some View {
        VStack {
            HStack {
                Button { action() } label: { Image(systemName: "text.justify") }
                Spacer()
            }
            Spacer()
        }
        .padding()
    }
}
