//
//  Date+Extention.swift
//  Smado
//
//  Created by Sergei Volkov on 07.05.2022.
//

import Foundation


extension Date {
    func addOrSubtructDay (day:Int) -> Date {
      return Calendar.current.date(byAdding: .day, value: day, to: self)!
    }
}
