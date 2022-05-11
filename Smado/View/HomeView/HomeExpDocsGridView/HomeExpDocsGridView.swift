//
//  DocumentsGridView.swift
//  Smado
//
//  Created by Sergei Volkov on 12.02.2022.
//

import SwiftUI

struct HomeExpDocsGridView: View {
    @EnvironmentObject private var categoryVM: CategoryViewModel
    
    private let expiresData = [
        DocumentsGridModel(image: "xmark.circle", color: .gray, status: .expired),
        DocumentsGridModel(image: "exclamationmark.triangle", color: .red, status: .today),
        DocumentsGridModel(image: "note.text", color: .yellow, status: .thisWeek),
        DocumentsGridModel(image: "calendar", color: .blue, status: .thisMonth),
    ]
    
    private var width: CGFloat {
        print(UIScreen.main.bounds.width)
        switch UIScreen.main.bounds.width {
                //4' ipodtouch, se1
            case 320:
                if UIDevice.current.orientation.isPortrait {
                    return 136
                } else {
                    return 128
                }
//                return 128
                
                //4.7' iphone 8, se2020-21, 12-13 mini, 11 pro
            case 375: return 164
                
                //13, 13pro
            case 390: return 172
                
                // 11, 11 pro max, 8 plus
            case 414: return 184
                
                //13 pro max
            case 428: return 190
                
                //ipad mini
            case 744: return 170
                
                //ipad 9.7'
            case 768: return 170
                
                //ipad base
            case 810: return 180
                
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
    @State private var refreshedID = UUID()

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \DocumentCD.dateEnd, ascending: false)],
        animation: .default)
    private var documents: FetchedResults<DocumentCD>
    
    var body: some View {
        VStack {
            LazyVGrid(columns: columns, alignment: .center, spacing: 10) {
                Section(header:
                            Text("Documents expires:").font(.system(size: 16, weight: .semibold, design: .monospaced))
                ) {
                    ForEach(expiresData, id: \.self) { item in

                        NavigationLink {
                            ExpiredDocsGridView(docs: CDStack.shared.filterdocs(documents: documents, expiresStatus: item.status), expiredStatus: item.status)
                        } label: {
                            HomeExpDocsGridCell(item: item, documents: documents, width: width)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }.id(refreshedID)
        .onRotate { newOrientation in
            if newOrientation != .unknown {
                refreshedID = UUID()
            }
        }
    }
    
}
