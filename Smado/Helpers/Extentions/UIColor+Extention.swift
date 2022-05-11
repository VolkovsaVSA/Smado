//
//  UIColor+Extention.swift
//  Neslis
//
//  Created by Sergey Volkov on 27.10.2020.
//

import Foundation
import SwiftUI


extension UIColor {
     class func color(data: Data) -> UIColor? {
          return try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIColor
     }

     func encode() -> Data? {
          return try? NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
     }
}
