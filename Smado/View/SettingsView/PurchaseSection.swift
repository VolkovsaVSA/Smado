//
//  PurchaseSection.swift
//  Smado
//
//  Created by Sergei Volkov on 21.04.2022.
//

import SwiftUI

struct PurchaseSection: View {
    
    
    var body: some View {
        Section(header: Text("Purchases").fontWeight(.semibold).foregroundColor(.primary)){
            NavigationLink {
                PurchaseView()
            } label: {
                HStack {
                    SettingsIcon(systemName: "key.icloud", color: .purple)
                    Text("Choose plan")
                }
            }
        }
    }
}
