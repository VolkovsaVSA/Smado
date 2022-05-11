//
//  ImageCD+CoreDataProperties.swift
//  Smado
//
//  Created by Sergei Volkov on 11.05.2022.
//
//

import Foundation
import CoreData


extension ImageCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageCD> {
        return NSFetchRequest<ImageCD>(entityName: "ImageCD")
    }

    @NSManaged public var data: Data?
    @NSManaged public var fileExtention: String?
    @NSManaged public var fileName: String?
    @NSManaged public var id: UUID?
    @NSManaged public var parentDocument: DocumentCD?

}

extension ImageCD : Identifiable {

}
