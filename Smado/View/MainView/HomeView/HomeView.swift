//
//  ContentView.swift
//  Smado
//
//  Created by Sergei Volkov on 04.02.2022.
//

import SwiftUI
import CoreData
import UserNotifications

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \CategoryCD.craetedDate, ascending: true)],
        animation: .default)
    private var categories: FetchedResults<CategoryCD>
    

    @State private var columns = [GridItem(.adaptive(minimum: UIDevice.isIPad ? UIScreen.main.bounds.width * 0.17 : UIScreen.main.bounds.width * 0.3))]

    @State private var showSettings = false
    @State private var showAddDocument = false
    @State private var newDocument: DocumentCD? = nil

//    @State var searchText = ""

    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                VStack(spacing: 0) {
                    HomeExpDocsGridView()
                        .padding()
                    GradientLine()
                    HomeCategoriesGridView()
                    Spacer()
                }

                if !categories.isEmpty {
                    DocumentsPlusButton() { documentPlusButtonAction() }
                }

                SettingsButton { showSettings.toggle() }

            }
            .onAppear() { initNotifications() }
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.bottom)
            
            .sheet(isPresented: $showSettings) { SettingsView() }
            .sheet(isPresented: $showAddDocument) {
                newDocument = nil
            } content: {
                if let doc = newDocument {
                    DocumentDetailView(document: doc, isNewDocument: true)
                }
            }
//            .searchable(text: $searchText)
        }
        .navigationViewStyle(.stack)
    }


}


extension HomeView {
    
    fileprivate func initNotifications() {
        if !UserDefaults.standard.bool(forKey: UDKeys.notFirstRun) {
            NotificationManager.requestAuthorization { success in
                UserDefaults.standard.set(success, forKey: UDKeys.sendNotifications)
            }
            UserDefaults.standard.set(true, forKey: UDKeys.notFirstRun)
        }
    }
    
    fileprivate func documentPlusButtonAction() {
        withAnimation {
            if let cat = categories.first {
                newDocument = CDStack.shared.createDocument(category: cat, title: "", comment: nil, dateEnd: Date(), folder: nil)
                showAddDocument.toggle()
            }
        }
    }
    
}
