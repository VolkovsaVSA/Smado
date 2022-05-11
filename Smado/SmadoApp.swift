//
//  SmadoApp.swift
//  Smado
//
//  Created by Sergei Volkov on 04.02.2022.
//

import SwiftUI

@main
struct SmadoApp: App {
    private let cd = CDStack.shared
    private let storeManager = StoreManager.shared

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, cd.container.viewContext)
                .environmentObject(storeManager)
                .onReceive(NotificationCenter.default.publisher(for: .NSPersistentStoreRemoteChange), perform: { _ in
                    print("cloudkit udated")
                })
        }
    }
}
