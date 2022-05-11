//
//  Extention+UIDevice.swift
//  Smado
//
//  Created by Sergei Volkov on 11.02.2022.
//

import UIKit

extension UIDevice {
    
    // userInterfaceIdiom
    static var isIPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    static var isIPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
}
