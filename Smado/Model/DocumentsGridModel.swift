//
//  ExpiresCellModel.swift
//  Smado
//
//  Created by Sergei Volkov on 12.02.2022.
//

import Foundation
import SwiftUI

struct DocumentsGridModel: Hashable {
    let image: String
    let color: Color
    let status: ExpiredStatus
}
