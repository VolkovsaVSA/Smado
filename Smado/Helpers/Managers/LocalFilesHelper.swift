//
//  LocalFilesHelper.swift
//  Smado
//
//  Created by Sergei Volkov on 20.03.2022.
//

import Foundation

struct LocalFilesHelper {
    static var documentDirectory: URL {
        try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    }
    static var libraryDirectory: URL {
        try! FileManager.default.url(for: .libraryDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    }
    
    static func writeTempFile(data: Data, fileName: String) -> URL? {
        let fileUrl = libraryDirectory.appendingPathComponent(fileName)
        
        do {
            try removeOldFile(path: fileUrl.path)
        } catch {
            return nil
        }
        
        do {
            try data.write(to: fileUrl, options: .atomic)
        } catch {
            return nil
        }
        
        return fileUrl
    }

//    static func writeFile(data: Data, fileName: String) throws {
//        
//        var tempFileName = fileName
//        
//        if FileManager.default.fileExists(atPath: documentDirectory.appendingPathComponent(fileName).path) {
//            tempFileName = ImagePicker.conversionFileName(lastPathComponent: fileName)
//        }
//
//        do {
//            try data.write(to: documentDirectory.appendingPathComponent(tempFileName), options: .atomic)
//            print(documentDirectory.appendingPathComponent(tempFileName))
//        } catch {
//            throw error
//        }
//        
//
//    }
    
    
    static func removeOldFile (path: String) throws {
        var isDir:ObjCBool = false
        
        if FileManager.default.fileExists(atPath: path, isDirectory: &isDir) {
            do {
                try FileManager.default.removeItem(atPath: path)
            } catch {
                throw error
            }
        } else {
            print("Deleted file no exists")
        }
    }
}
