//
//  SettingsView.swift
//  Smado
//
//  Created by Sergei Volkov on 18.04.2022.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var storeManager: StoreManager
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    
    private var columns: [GridItem] {
        [GridItem(.adaptive(minimum: 150))]
    }
    
    var body: some View {
        
        NavigationView {

            Form {
                
                Group {
                    PurchaseSection()
                    BackupSection()
                    VisualSection()
                    NotificationSection()
                    FeedbackSection()
                }
                .font(.system(size: 17, weight: .light, design: .default))
            }
//            .background(colorScheme == .dark ? .black : Color(uiColor: UIColor.systemGroupedBackground))
//            .onAppear {
//              UITableView.appearance().backgroundColor = .clear
//            }
            
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button { dismiss() } label: { Text("Back") }
                }
            }
        }
        .onAppear {
            Task { try? await storeManager.loadProducts() }
        }
        .modifier(ChooseColorSchemeViewModifire())
    }
    
}
