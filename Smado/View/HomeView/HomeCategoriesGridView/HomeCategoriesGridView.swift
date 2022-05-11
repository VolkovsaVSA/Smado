//
//  CategoriesGridView.swift
//  Smado
//
//  Created by Sergei Volkov on 12.02.2022.
//

import SwiftUI

struct HomeCategoriesGridView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject private var categoryVM: CategoryViewModel
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \CategoryCD.craetedDate, ascending: true)],
        animation: .default)
    private var categories: FetchedResults<CategoryCD>
    
    @State private var showAddCategory = false
    @State private var showDeleteAlert = false
    @State private var deletingCategory: CategoryCD? = nil
    
    
    var body: some View {

        List {
            
            Section(
                header:
                    HStack {
                        Text("Categories" + " " + "(" + categories.count.description + ")")
                        Spacer()
                        Button {
                            withAnimation { showAddCategory.toggle() }
                        } label: {
                            Image(systemName: "plus")
                        }
                        .buttonStyle(.bordered)
                    }
            ) {
                ForEach(categories) { category in
                    HomeCategoriesGridCell(category: category)
                        .padding(.bottom, 10)
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button(role: .destructive) {
                                deletingCategory = category
                                showDeleteAlert.toggle()
                            } label: {
                                Image(systemName: "trash")
                            }
                        }
                }
                
                MockSpaceInList(height: 40)
            }
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
     
        }
        .listStyle(.plain)
        
        .alert("Attention!", isPresented: $showDeleteAlert, actions: {
            Button("Delete", role: .destructive) {
                withAnimation {
                    if let cat = deletingCategory {
                        viewContext.delete(cat)
                        CDStack.shared.saveContext(context: viewContext)
                    }
                }
            }
        }, message: {
            Text("If you delete this category, all related documents will be deleted! Are you sure?")
        })
        
        .sheet(isPresented: $showAddCategory) {
            AddCategoryView()
        }
        
    }
    
}

