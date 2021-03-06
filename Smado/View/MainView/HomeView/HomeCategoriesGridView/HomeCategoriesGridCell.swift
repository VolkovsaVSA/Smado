//
//  CategoriesGridCell.swift
//  Smado
//
//  Created by Sergei Volkov on 13.02.2022.
//

import SwiftUI

struct HomeCategoriesGridCell: View {
    @Environment(\.colorScheme) private var colorScheme
    
    @StateObject var category: CategoryCD
    
    var body: some View {
        
        HStack {
            Image(systemName: category.image ?? "")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundColor(.blue.opacity(0.9))
            Text(category.title ?? "")
            Spacer()
            Image(systemName: "doc.on.doc")
                .foregroundColor(.blue.opacity(0.8))
                .font(.system(size: 17, weight: .thin, design: .default))
            Text(category.unwrapDocuments.count.description).fontWeight(.thin)
        }
        .padding()
        .background(
            Color(UIColor.tertiarySystemBackground)
                .cornerRadius(12)
                .background(
                     NavigationLink(destination: DocumentsGridView(category: category)) {EmptyView()}
                 )
                .modifier(CellShadowModifire())
        )
        
    }
}


