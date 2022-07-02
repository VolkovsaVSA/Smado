//
//  CategoryView.swift
//  Smado
//
//  Created by Sergei Volkov on 13.02.2022.
//

import SwiftUI
import CoreData

struct DocumentsGridView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    private let columns: [GridItem]
    private let width: CGFloat
    @State private var showAddDocument = false
    @State private var selectedDocument: DocumentCD?
    @State private var showEditView = false
    @State private var editCategory = false

    
    let category: CategoryCD
    
    init(category: CategoryCD) {
        switch UIScreen.main.bounds.width {
            case 320:
                self.width = 90
            case 428:
                self.width = 120
            default:
                self.width = 106
        }
        self.category = category
        self.columns = [GridItem(.adaptive(minimum: width))]
    }
    
    
    
    var body: some View {
        
        ScrollView {
            GradientLine()
            LazyVGrid(columns: columns, alignment: .center, spacing: 12) {
                ForEach(category.unwrapDocuments.sorted {$0.dateEnd ?? Date() < $1.dateEnd ?? Date()}) { doc in
                    
                    DocumentMenuAction(doc: doc, width: width) {
                        selectedDocument = doc
                        withAnimation { showEditView = true }
                    }
                    
                }
            }
            .padding()
        }
        .overlay(
            DocumentsPlusButton() {
                withAnimation {
                    selectedDocument = CDStack.shared.createDocument(category: category, title: "", dateEnd: Date())
                    showAddDocument.toggle()
                }
            }
        )
        .edgesIgnoringSafeArea(.bottom)
        .navigationTitle(category.title ?? "")
        
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    editCategory.toggle()
                } label: {
                    Image(systemName: "square.and.pencil")
                }
            }
        }
//        .quickLookPreview($selectedUrl, in: imageUrls)
        .sheet(isPresented: $showEditView) {
            selectedDocument = nil
        } content: {
            if let doc = selectedDocument {
                DocumentDetailView(document: doc, isNewDocument: false)
            }
        }
        .sheet(isPresented: $showAddDocument) {
            selectedDocument = nil
        } content: {
            if let doc = selectedDocument {
                DocumentDetailView(document: doc, isNewDocument: true)
            }
        }
        .sheet(isPresented: $editCategory) {
            AddCategoryView(category: category)
        }
            
    }
}


