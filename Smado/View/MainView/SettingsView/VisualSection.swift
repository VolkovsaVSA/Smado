//
//  VisualSection.swift
//  Smado
//
//  Created by Sergei Volkov on 22.05.2022.
//

import SwiftUI

struct VisualSection: View {
    
    @State private var preferedColorscheme: ColorSchemeModel
    
    init() {
        preferedColorscheme = ColorSchemeModel(rawValue: UserDefaults.standard.string(forKey: UDKeys.colorScheme) ?? ColorSchemeModel.system.rawValue) ?? ColorSchemeModel.system
    }
    
    var body: some View {
        
        Section(header: Text("Theme").fontWeight(.semibold).foregroundColor(.primary)){
            HStack {
                SettingsIcon(systemName: "paintbrush", color: .indigo)
                Picker("Theme", selection: $preferedColorscheme) {
                    ForEach(ColorSchemeModel.allCases, id: \.self) {item in
                        Text(item.localize)
                            
                    }
                }
//                .onAppear() {
//                    UITableView.appearance().backgroundColor = .systemGroupedBackground
//                }
//                .onDisappear() {
//                  UITableView.appearance().backgroundColor = .clear
//                }
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
            }
            
        }
        .onChange(of: preferedColorscheme) { newValue in
            UserDefaults.standard.set(preferedColorscheme.rawValue, forKey: UDKeys.colorScheme)
        }
    }
}
