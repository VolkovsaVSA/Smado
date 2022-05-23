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
    private let frameHeight: CGFloat = 30
    
    @Binding var title: String
    @Binding var dateEnd: Date
    @Binding var category: CategoryCD?
    
    var body: some View {
        
        Section(header: Text("Document data")) {
            
            GroupBox {
                TextField("Title", text: $title)
                    .font(.system(size: 16, weight: .bold, design: .default))
                    .submitLabel(.done)
                DatePicker("Deadline", selection: $dateEnd, in: Date()..., displayedComponents: [.date])
//                    .font(.system(size: 15, weight: .thin, design: .default))
                HStack {
                    Text("Category")
//                        .font(.system(size: 15, weight: .thin, design: .default))
                    Spacer()
                    Picker("", selection: $category) {
                        ForEach(categories) { cat in
                            Text(cat.title ?? "").tag(cat as CategoryCD?)
                        }
                    }
                    .pickerStyle(.menu)
                }
            }
            .groupBoxStyle(DocInfSectionStyle())
//            .font(.system(size: 15, weight: .thin, design: .default))
            
        }
        .listRowSeparator(.hidden)
    }
    
}

