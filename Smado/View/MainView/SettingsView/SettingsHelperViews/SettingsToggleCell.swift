//
//  SettingsViewCell.swift
//  Debts
//
//  Created by Sergei Volkov on 25.12.2021.
//

import SwiftUI

struct SettingsToggleCell: View {
    
    let title: String
    let systemImage: String
    @Binding var isOn: Bool
    let backgroundColor: Color
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            SettingsIcon(systemName: systemImage, color: backgroundColor)
            Toggle(title, isOn: $isOn)
        }
        .listRowSeparator(.hidden)
        .lineLimit(nil)
        .multilineTextAlignment(.leading)
    }
}
