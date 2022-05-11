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

    
    var body: some View {
        
        NavigationView {
            Form {
                
                Group {
                    PurchaseSection()
                    BackupSection()
                    NotificationSection()
                    FeedbackSection()
                }
                .font(.system(size: 17, weight: .light, design: .default))

            }
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
    }
    
}
