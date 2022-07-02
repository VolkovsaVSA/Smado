//
//  CategoryCD+CoreDataProperties.swift
//  Smado
//
//  Created by Sergei Volkov on 11.05.2022.
//
//

import Foundation
import CoreData


extension CategoryCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryCD> {
        let request = NSFetchRequest<CategoryCD>(entityName: "CategoryCD")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \CategoryCD.craetedDate, ascending: true)]
        return request
    }

    @NSManaged public var craetedDate: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var image: String?
    @NSManaged public var title: String?
    @NSManaged public var documents: NSSet?
    @NSManaged public var folders: NSSet?

}

// MARK: Generated accessors for documents
extension CategoryCD {

    @objc(addDocumentsObject:)
    @NSManaged public func addToDocuments(_ value: DocumentCD)

    @objc(removeDocumentsObject:)
    @NSManaged public func removeFromDocuments(_ value: DocumentCD)

    @objc(addDocuments:)
    @NSManaged public func addToDocuments(_ values: NSSet)

    @objc(removeDocuments:)
    @NSManaged public func removeFromDocuments(_ values: NSSet)

}

// MARK: Generated accessors for folders
extension CategoryCD {

    @objc(addFoldersObject:)
    @NSManaged public func addToFolders(_ value: FolderCD)

    @objc(removeFoldersObject:)
    @NSManaged public func removeFromFolders(_ value: FolderCD)

    @objc(addFolders:)
    @NSManaged public func addToFolders(_ values: NSSet)

    @objc(removeFolders:)
    @NSManaged public func removeFromFolders(_ values: NSSet)

}

extension CategoryCD : Identifiable {

}

