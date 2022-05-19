//
//  DocumentDataSection.swift
//  Smado
//
//  Created by Sergei Volkov on 21.04.2022.
//

import SwiftUI

struct DocDataSection: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \CategoryCD.craetedDate, ascending: true)],
        animation: .default)
    private var categories: FetchedResults<CategoryCD>
    
    @Binding var title: String
    @Binding var dateEnd: Date
    @Binding var category: CategoryCD?
    
    var body: some View {
        
        Section(header: Text("Document data")) {
            
            TextField("Title", text: $title)
                .font(.system(size: 16, weight: .bold, design: .default))
                .submitLabel(.done)
            DatePicker("Deadline", selection: $dateEnd, in: Date()..., displayedComponents: [.date])
            HStack {
                Text("Category")
                Spacer()
                Picker("", selection: $category) {
                    ForEach(categories) { cat in
                        Text(cat.title ?? "").tag(cat as CategoryCD?)
                    }
                }
                .pickerStyle(.menu)
            }
            
            
            
            
            
//            HStack {
//                VStack(alignment: .leading, spacing: 2) {
//                    Text("Title")
//                        .font(.system(size: 12, weight: .thin, design: .default))
//                    TextField("Enter the title", text: $title)
//                        .font(.system(size: 16, weight: .bold, design: .default))
//                        .submitLabel(.done)
//                        .frame(height: 36)
//                }
//                VStack(alignment: .trailing, spacing: 2) {
//                    Text("Deadline")
//                        .font(.system(size: 12, weight: .thin, design: .default))
//                    DatePicker("", selection: $dateEnd, in: Date()..., displayedComponents: [.date])
//                        .frame(height: 36)
//                }
//            }
//            .newDocSectionStyle()
//
//            HStack {
//                Text("Category")
//                Spacer()
//                Picker("", selection: $category) {
//                    ForEach(categories) { cat in
//                        Text(cat.title ?? "").tag(cat as CategoryCD?)
//                    }
//                }
//                .pickerStyle(.menu)
//            }
//            .newDocSectionStyle()
        }
        .listRowSeparator(.hidden)
    }
    
}

