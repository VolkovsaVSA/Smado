//
//  DocumentsGridView.swift
//  Smado
//
//  Created by Sergei Volkov on 12.02.2022.
//

import SwiftUI

struct HomeExpDocsGridView: View {
    
    @State private var rotateRefreshedID = UUID()

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \DocumentCD.dateEnd, ascending: false)],
        animation: .default)
    private var documents: FetchedResults<DocumentCD>
    
    var body: some View {
        VStack {
            LazyVGrid(columns: columns, alignment: .center, spacing: 10) {
                Section(header:
                            Text("Expires:").font(.system(size: 16, weight: .semibold, design: .default))
                ) {
                    ForEach(expiresData, id: \.self) { item in

                        NavigationLink {
                            ExpiredDocsGridView(docs: CDStack.shared.filterdocs(documents: documents, expiresStatus: item.status), expiredStatus: item.status)
                        } label: {

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
                        .buttonStyle(.plain)
                    }
                }
            }
        }
        .id(rotateRefreshedID)
        .onRotate { newOrientation in
            if newOrientation != .unknown {
                rotateRefreshedID = UUID()
            }
        }
    }
    
}

extension HomeExpDocsGridView {
    
    private var expiresData: [DocumentsGridModel]  {[
        DocumentsGridModel(image: "xmark.circle", color: .gray, status: .expired),
        DocumentsGridModel(image: "exclamationmark.triangle", color: .red, status: .today),
        DocumentsGridModel(image: "note.text", color: .yellow, status: .thisWeek),
        DocumentsGridModel(image: "calendar", color: .blue, status: .thisMonth),
    ]}
    
    private var width: CGFloat {
        
        print(UIScreen.main.bounds.width)
        
        switch UIScreen.main.bounds.width {
                //4' ipodtouch, se1
            case 320: return 136

                //4.7' iphone 8, se2020-21, 12-13 mini, 11 pro
            case 375: return 164
                
                //13, 13pro
            case 390: return 172
                
                // 11, 11 pro max, 8 plus
            case 414: return 184
                
                //13 pro max
            case 428: return 190
                
                //4' ipodtouch, se1 landscape orientation
            case 568: return 128
                
                //ipad mini
            case 744: return 170
                
                //ipad 9.7'
            case 768: return 170
                
                //ipad base
            case 810: return 180
                //
            case 812: return 160
                //ipad air
            case 820: return 180
                
                //ipad 11'
            case 834: return 190
                
                //ipad 12.9'
            case 1024: return 230
                
            default: return 170
        }
    }
    
    private var columns: [GridItem] {
        [GridItem(.adaptive(minimum: width))]
    }
    
}
