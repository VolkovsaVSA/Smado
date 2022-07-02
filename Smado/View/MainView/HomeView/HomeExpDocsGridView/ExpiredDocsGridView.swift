//
//  ExpiredDocsGridView.swift
//  Smado
//
//  Created by Sergei Volkov on 04.04.2022.
//

import SwiftUI

struct ExpiredDocsGridView: View {
    
    private let columns: [GridItem]
    private let width: CGFloat
    private let status: ExpiredStatus
    
    @State private var selectedDocument: DocumentCD?
    @State private var showEditView = false
    @State private var refreshID = UUID()
    
    var documents: [DocumentCD]
    
    init(docs: [DocumentCD], expiredStatus: ExpiredStatus) {
        switch UIScreen.main.bounds.width {
            case 320:
                self.width = 90
            case 428:
                self.width = 120
            default:
                self.width = 106
        }
        self.columns = [GridItem(.adaptive(minimum: width))]
        self.documents = docs
        self.status = expiredStatus
    }
    
    var body: some View {
        
        ZStack {
            ScrollView {
                GradientLine()
                LazyVGrid(columns: columns, alignment: .center, spacing: 12) {
                    ForEach(documents) { doc in
                        
                        DocumentMenuAction(doc: doc, width: width){
                            selectedDocument = doc
                            refreshID = UUID()
                            withAnimation { showEditView.toggle() }
                        }

                    }
                }
                .padding()
            }
        }
        .id(refreshID)
        .navigationTitle(ExpiredStatus.localize(status: status))
        
        .sheet(isPresented: $showEditView) {
            if let doc = selectedDocument {
                DocumentDetailView(document: doc, isNewDocument: false)
            }
        }
    }
}


