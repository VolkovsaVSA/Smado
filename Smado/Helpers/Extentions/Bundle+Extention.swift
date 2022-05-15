//
//  Bundle+Extention.swift
//  Smado
//
//  Created by Sergei Volkov on 15.05.2022.
//

import Foundation

extension Bundle {
    public var appName: String { getInfo("CFBundleName")  }
    public var displayName: String {getInfo("CFBundleDisplayName")}
    public var language: String {getInfo("CFBundleDevelopmentRegion")}
    public var identifier: String {getInfo("CFBundleIdentifier")}
    public var copyright: String {getInfo("NSHumanReadableCopyright")
//        .replace(of: "\\\\n", to: "\n")
    }
    
    public var appBuild: String { getInfo("CFBundleVersion") }
    public var appVersionShort: String { getInfo("CFBundleShortVersionString") }

    fileprivate func getInfo(_ str: String) -> String { infoDictionary?[str] as? String ?? "⚠️" }
}
