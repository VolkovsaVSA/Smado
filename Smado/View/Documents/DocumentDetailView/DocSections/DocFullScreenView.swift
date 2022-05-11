////
////  DocFullScreenView.swift
////  Smado
////
////  Created by Sergei Volkov on 29.04.2022.
////
//
//import SwiftUI
//
//struct DocFullScreenView: View {
//    
//    @State var selectedImage: ImageCD
//    @Binding var fullScreen: Bool
//    
//    var body: some View {
//        ZStack {
//            
//            if let data = selectedImage.data
//            {
//                if selectedImage.fileExtention?.lowercased() == "pdf" {
//                    PDFKitView(data: data, singlePage: false)
//                } else {
//                    if let uiImage = UIImage(data: data) {
//                        PDFViewForImage(image: uiImage)
//                            .ignoresSafeArea()
//                    }
//                }
//            }
//           
//            
//            VStack {
//                HStack {
//                    Button {
//                        fullScreen = false
//                    } label: {
//                        IconImageView(image: "plus", color: .black, imageScale: 12)
//                            .rotationEffect(.degrees(45))
//                            .padding()
//                    }
//                    Spacer()
//                }
//                Spacer()
//            }
//        }
//    }
//}
