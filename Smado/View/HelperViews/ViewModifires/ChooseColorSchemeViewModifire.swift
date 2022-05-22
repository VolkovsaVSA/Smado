//
//  ChooseColorSchemeViewModifire.swift
//  Debts
//
//  Created by Sergei Volkov on 22.12.2021.
//

import SwiftUI


struct ChooseColorSchemeViewModifire: ViewModifier {
    
    @AppStorage(UDKeys.colorScheme) private var selectedScheme: String = "system"
   
    func body(content: Content) -> some View {
        content
            .preferredColorScheme(selectColorScheme(selectedScheme: selectedScheme))
    }
    
    private func selectColorScheme(selectedScheme: String) -> ColorScheme? {
        
        switch selectedScheme {
            case "light": return ColorScheme.light
            case "dark": return ColorScheme.dark
            case "system": return .none
            default: return .none
        }
    }
}
