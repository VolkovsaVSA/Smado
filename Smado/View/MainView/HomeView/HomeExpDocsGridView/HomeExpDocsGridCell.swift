//
//  ExpiresCell.swift
//  Smado
//
//  Created by Sergei Volkov on 12.02.2022.
//

import SwiftUI

struct HomeExpDocsGridCell: View {
    
    @State var item: DocumentsGridModel
    @State var documents: FetchedResults<DocumentCD>
    @State var width: CGFloat

    var body: some View {
        
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                IconImageView(image: item.image, color: item.color, imageScale: 16)
                Spacer()
                Text(CDStack.shared.filterdocs(documents: documents, expiresStatus: item.status).count.description)
                    .font(.system(size: 24))
                    .fontWeight(.bold)
            }
            
            Text(ExpiredStatus.localize(status: item.status))
                .font(.system(size: 14, weight: .light, design: .default))
                .foregroundColor(.secondary)
        }
        .gridCellStyle(width: width)
        
    }
    
}

