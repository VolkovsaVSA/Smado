//
//  View+Extention.swift
//  Smado
//
//  Created by Sergei Volkov on 16.02.2022.
//

import SwiftUI

extension View {
    
    func documentPicker(isPresented: Binding<Bool>, files: Binding<[FileModel]>, callBack: @escaping ([(String, Int)])->Void) -> some View {
        self
        .fileImporter(isPresented: isPresented,
                      allowedContentTypes: [.image, .pdf],
                      allowsMultipleSelection: true)
        { result in
            
            print(result)
            
            var bigFiles = [(String, Int)]()

            switch result {
                case .success(let urls):
                    
                    urls.forEach { url in
                        print(url)
                        if url.pathExtension.lowercased() == "pdf" {
                            guard let data = FileManager.default.contents(atPath: url.path) else { return }
                            if data.count > 4_000_000 {
                                print("\(url.lastPathComponent): \(data.count)")
                                bigFiles.append((url.lastPathComponent, data.count))
                            } else {
                                files.wrappedValue.append(FileModel(data: data, fileName: url.lastPathComponent))
                            }
                        } else {
                            guard let data = ImageHelper.compressImageWithURL(url: url) else { return }
                            files.wrappedValue.append(FileModel(data: data, fileName: url.lastPathComponent))
                        }
                    }
                case .failure(let error):
                    print(error)
            }
            
            callBack(bigFiles)
            
        }
//        .onDisappear() {
//            files.wrappedValue = []
//        }
    }
    
    //styles
    func categoriesCellStyle(padding: CGFloat) -> some View {
        self
            .padding(padding)
            .background(
                Color(UIColor.tertiarySystemBackground)
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.2), radius: 6, x: 0, y: 3)
            )
    }
    func newDocSectionStyle() -> some View {
        self.categoriesCellStyle(padding: 12)
    }
    
    func gridCellStyle(width: CGFloat) -> some View {
        self
            .padding(12)
            .frame(width: width,
                   height: 70,
                   alignment: .center
            )
            .background(
                Color(UIColor.tertiarySystemBackground)
                    .blur(radius: 6, opaque: true)
                    .cornerRadius(12)
            )
            .shadow(color: .black.opacity(0.2), radius: 6, x: 0, y: 3)
    }
    
    //Views
    func popUpView<Content: View>(hPadding: CGFloat = 40,
                                  show: Binding<Bool>,
                                  @ViewBuilder content: @escaping ()->Content) -> some View {
        return self
//            .blur(radius: show.wrappedValue ? 20 : 0, opaque: true)
//            .disabled(show.wrappedValue)
            .overlay {
                if show.wrappedValue {
                    
                    ZStack {
                        
                        Color.clear
                            .background(.ultraThinMaterial)
                        
                        GeometryReader { proxy in
                            let size = proxy.size
                            content()
                            .frame(width: size.width - hPadding, height: size.height /* / 2 */, alignment: .center)
                            .cornerRadius(15)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        }
                    }.ignoresSafeArea()

                }
                
            }
    }
    
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}


struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}
