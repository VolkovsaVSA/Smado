//
//  URL+Extention.swift
//  Smado
//
//  Created by Sergei Volkov on 14.03.2022.
//

import Foundation

extension String {
    func lastComponent(maxCharacters: Int) -> String {
        self.count > maxCharacters ?
        String(self.dropLast(self.count - maxCharacters)) + "..."
        : self
    }
}
