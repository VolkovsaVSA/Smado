//
//  HomeCatHeader.swift
//  Smado
//
//  Created by Sergei Volkov on 11.05.2022.
//

import SwiftUI

struct HomeCatHeader: View {
    
    @State var categories: FetchedResults<CategoryCD>
    let action: ()->()
    
    var body: some View {
        HStack {
            Text("Categories (\(categories.count.description))")
            Spacer()
            Button { action() } label: { Image(systemName: "plus") }
            .buttonStyle(.bordered)
        }
    }
}
