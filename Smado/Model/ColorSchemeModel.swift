//
//  ColorSchemeModel.swift
//  Debts
//
//  Created by Sergei Volkov on 22.12.2021.
//

import Foundation
import SwiftUI

enum ColorSchemeModel: String, CaseIterable {

    case light, dark, system

    var localize: String  {
        var statusString: String = ""
        switch self {
            case .light: statusString = NSLocalizedString("Light", comment: "ColorScheme")
            case .dark: statusString = NSLocalizedString("Dark", comment: "ColorScheme")
            case .system: statusString = NSLocalizedString("System", comment: "ColorScheme")
        }
        return statusString
    }

}
