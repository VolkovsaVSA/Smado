//
//  AccessLimits.swift
//  Smado
//
//  Created by Sergei Volkov on 22.05.2022.
//

import Foundation

enum AccessLimits {
    static var maxFileSizeBytes: Int {
        UserDefaults.standard.bool(forKey: UDKeys.fwu) ? 50_000_000 : 1_000_000
    }
    static var maxSelectedFiles: Int {
        UserDefaults.standard.bool(forKey: UDKeys.fwu) ? 0 : 5
    }
    static var maxStoredFiles: Int {
        UserDefaults.standard.bool(forKey: UDKeys.fwu) ? 1000 : 100
    }
}
