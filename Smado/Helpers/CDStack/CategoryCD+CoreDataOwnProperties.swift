//
//  CategoryCD+CoreDataOwnProperties.swift
//  Smado
//
//  Created by Sergei Volkov on 11.05.2022.
//

import Foundation

extension CategoryCD {
    
    var unwrapDocuments: [DocumentCD] {
        guard let objects = documents?.allObjects as? [DocumentCD] else {return []}
        return objects
    }
    
}
