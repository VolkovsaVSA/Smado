//
//  CategoriesGridCell.swift
//  Smado
//
//  Created by Sergei Volkov on 13.02.2022.
//

import SwiftUI

struct HomeCategoriesGridCell: View {
    
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
            Text(category.documents?.count.description ?? "0").fontWeight(.thin)
        }
        .padding()
        .background(
            Color(UIColor.tertiarySystemBackground)
                .cornerRadius(12)
                .background(
                     NavigationLink(destination: DocumentsGridView(category: category)) {EmptyView()}
                 )
                .shadow(color: .black.opacity(0.2), radius: 6, x: 0, y: 3)
        )
        
    }
}


