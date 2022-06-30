//
//  DocFilesSection.swift
//  Smado
//
//  Created by Sergei Volkov on 21.04.2022.
//

import SwiftUI
import QuickLook

struct DocFilesSection: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var refreshfilesID = UUID()
    @State private var tempUrl: URL? = nil
    private var height: CGFloat { UIScreen.main.bounds.width / 0.8 }
    @State private var previewControllerShow = false
    
    @Binding var document: DocumentCD?

    
    var body: some View {
        
        if let images = document?.unwrapImages {
            
            if !images.isEmpty {
                
                Section(header: Text("Files (\(images.count))")) {
                    
                    ForEach(images) { image in
                        VStack {
                            Text(image.fileName?.lastComponent(maxCharacters: 40) ?? "no file name")
                                .font(.system(size: 12, weight: .thin, design: .default))
                            DocImageView(image: image)
                        }
//                        .onTapGesture { tapToFile(image: image) }
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                viewContext.delete(image)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    withAnimation {
                                        refreshfilesID = UUID()
                                    }
                                }
                            } label: {
                                Label("", systemImage: "trash")
                            }
                        }
                        
                    }//ForEach
                    .id(refreshfilesID)
                    

                    MockSpaceInList(height: 50)
        
                }//section
                 
                .listRowSeparator(.hidden)
                .quickLookPreview($tempUrl)
            }
            
        }
            

        
    }
}

//
//extension DocFilesSection {
//    
//    fileprivate func tapToFile(image: ImageCD) {
//        if let data = image.data,
//           let fileName = image.fileName
//        {
//            tempUrl = LocalFilesHelper.writeTempFile(data: data, fileName: fileName)
//            previewControllerShow.toggle()
//        }
//    }
//    
//}
