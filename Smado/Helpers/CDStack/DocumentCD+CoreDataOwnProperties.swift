//
//  DocumentCD+CoreDataOwnProperties.swift
//  Smado
//
//  Created by Sergei Volkov on 11.05.2022.
//

import Foundation

extension DocumentCD {
    
    var unwrapImages: [ImageCD] {
        guard let objects = images?.allObjects as? [ImageCD] else {return []}
        return objects
    }
    
}
