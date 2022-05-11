//
//  ExpiresCellModel.swift
//  Smado
//
//  Created by Sergei Volkov on 12.02.2022.
//

import Foundation

enum ExpiredStatus: String, CaseIterable {
    case expired, today, thisWeek, thisMonth
    
    static func localize(status: Self) -> String {
        switch status {
            case .expired: return NSLocalizedString("Expired", comment: " ")
            case .today: return NSLocalizedString("Today", comment: " ")
            case .thisWeek: return NSLocalizedString("less 7 days", comment: " ")
            case .thisMonth: return NSLocalizedString("less 30 days", comment: " ")
//            case .notExpiries:
//                return ""
        }
    }
}
