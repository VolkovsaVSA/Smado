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
    private var height: CGFloat { UIScreen.main.bounds.width / 0.75 }
    
    @Binding var document: DocumentCD?
    
    
    fileprivate func tapToFile(image: ImageCD) {
        if let data = image.data,
           let fileName = image.fileName
        {
            tempUrl = LocalFilesHelper.writeTempFile(data: data, fileName: fileName)
        }
    }
    
    var body: some View {
        
        Section(header: Text("Files")) {
            
            if let images = document?.images?.allObjects as? [ImageCD] {
                
                ForEach(images) { image in
                    VStack {
                        Text(image.fileName ?? "no file name")
                            .font(.system(size: 12, weight: .thin, design: .default))
                        
                        Group {
                            if image.fileExtention?.lowercased() == "pdf" {
                                if let data = image.data {
                                    PDFKitView(data: data, singlePage: false)
                                        .frame(height: height)
                                } else {
                                    Image(systemName: "eye.slash")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(Color("imageFrameColor"))
                                }
                            } else {
                                DocumentImage(image: image)
                            }
                        }
                        .categoriesCellStyle(padding: 0)
                        
                        

                    }
                    .id(refreshfilesID)
                    .onTapGesture { tapToFile(image: image) }
                    
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            withAnimation {
                                viewContext.delete(image)
                                refreshfilesID = UUID()
                            }
                        } label: {
                            Label("", systemImage: "trash")
                        }
                    }
                }//ForEach
//                .onMove(perform: onMove)
                
                MockSpaceInList(height: 50)
                
                    
            }//if let images = document?.images?.allObjects
            
        }//section
        .listRowSeparator(.hidden)
        .quickLookPreview($tempUrl)
        
    }
}
