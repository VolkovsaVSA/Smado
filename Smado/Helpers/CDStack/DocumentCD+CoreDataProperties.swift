//
//  DocumentCD+CoreDataProperties.swift
//  Smado
//
//  Created by Sergei Volkov on 11.05.2022.
//
//

import Foundation
import CoreData


extension DocumentCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DocumentCD> {
        return NSFetchRequest<DocumentCD>(entityName: "DocumentCD")
    }

    @NSManaged public var comment: String?
    @NSManaged public var dateAdded: Date?
    @NSManaged public var dateEnd: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var notifMonth: Bool
    @NSManaged public var notifToday: Bool
    @NSManaged public var notifWeek: Bool
    @NSManaged public var title: String?
    @NSManaged public var images: NSSet?
    @NSManaged public var parentCategory: CategoryCD?
    @NSManaged public var parentFolder: FolderCD?

}

// MARK: Generated accessors for images
extension DocumentCD {

    @objc(addImagesObject:)
    @NSManaged public func addToImages(_ value: ImageCD)

    @objc(removeImagesObject:)
    @NSManaged public func removeFromImages(_ value: ImageCD)

    @objc(addImages:)
    @NSManaged public func addToImages(_ values: NSSet)

    @objc(removeImages:)
    @NSManaged public func removeFromImages(_ values: NSSet)

}

extension DocumentCD : Identifiable {

}
