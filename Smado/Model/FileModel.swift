//
//  FileModel.swift
//  Smado
//
//  Created by Sergei Volkov on 19.03.2022.
//

import Foundation
import UIKit

struct FileModel: Identifiable, Equatable, Hashable {
    var id = UUID()
    var data: Data
    var fileName: String
}
