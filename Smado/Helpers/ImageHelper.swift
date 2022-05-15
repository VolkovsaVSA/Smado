//
//  CompressImageHelper.swift
//  Smado
//
//  Created by Sergei Volkov on 03.05.2022.
//

import SwiftUI
import UniformTypeIdentifiers

class ImageHelper {
    private init() {}

    private static func compressImage(source: CGImageSource) -> Data? {
        let downsampleOptions = [
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceThumbnailMaxPixelSize: 1024,
        ] as CFDictionary

        guard let cgImage = CGImageSourceCreateThumbnailAtIndex(source, 0, downsampleOptions) else {return nil}

        let data = NSMutableData()
        guard let imageDestination = CGImageDestinationCreateWithData(data, UTType.jpeg.identifier as CFString, 1, nil) else {return nil}
        
        let isPNG: Bool = {
            guard let utType = cgImage.utType else { return false }
            return (utType as String) == UTType.png.identifier
        }()

        let destinationProperties = [
            kCGImageDestinationLossyCompressionQuality: isPNG ? 1.0 : 0.7
        ] as CFDictionary

        CGImageDestinationAddImage(imageDestination, cgImage, destinationProperties)
        CGImageDestinationFinalize(imageDestination)
        print("compressed data: \(data as Data)")
        return data as Data
    }
    
    static func compressImageWithURL(url: URL) -> Data? {
        let sourceOptions = [kCGImageSourceShouldCache: true] as CFDictionary
        guard let source = CGImageSourceCreateWithURL(url as CFURL, sourceOptions) else {
            return nil
        }
        
        return compressImage(source: source)
    }
    static func compressImageWithData(data: Data) -> Data? {
        let sourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        guard let source = CGImageSourceCreateWithData(data as CFData, sourceOptions) else {return nil}
        
        return compressImage(source: source)
    }
    static func drawPDFfromURL(url: URL) -> UIImage? {
        guard let document = CGPDFDocument(url as CFURL) else { return nil }
        return drawPDF(document: document)
    }
    
    static func drawPDFfromData(data: CFData) -> UIImage? {
        guard let dataProvider = CGDataProvider(data: data) else { return nil }
        guard let document = CGPDFDocument(dataProvider) else { return nil }
        return drawPDF(document: document)
    }
    private static func drawPDF(document: CGPDFDocument) -> UIImage? {
        guard let page = document.page(at: 1) else { return nil }
        
        let pageRect = page.getBoxRect(.mediaBox)
        let renderer = UIGraphicsImageRenderer(size: pageRect.size)
        let img = renderer.image { ctx in
            UIColor.white.set()
            ctx.fill(pageRect)
            ctx.cgContext.translateBy(x: 0.0, y: pageRect.size.height)
            ctx.cgContext.scaleBy(x: 1.0, y: -1.0)
            ctx.cgContext.drawPDFPage(page)
        }

        return img
    }
    
    static func compressData(_ data: Data) -> Data? {
        return try? (data as NSData).compressed(using: .lzma) as Data
    }
    static func decompressData(_ data: Data) -> Data? {
        return try? (data as NSData).decompressed(using: .lzma) as Data
    }
}

