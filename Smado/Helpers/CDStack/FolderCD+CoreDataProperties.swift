//
//  FolderCD+CoreDataProperties.swift
//  Smado
//
//  Created by Sergei Volkov on 11.05.2022.
//
//

import Foundation
import CoreData


extension FolderCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FolderCD> {
        return NSFetchRequest<FolderCD>(entityName: "FolderCD")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var childrenFolders: NSSet?
    @NSManaged public var documents: NSSet?
    @NSManaged public var parentCategory: CategoryCD?
    @NSManaged public var parentFolder: FolderCD?

}

// MARK: Generated accessors for childrenFolders
extension FolderCD {

    @objc(addChildrenFoldersObject:)
    @NSManaged public func addToChildrenFolders(_ value: FolderCD)

    @objc(removeChildrenFoldersObject:)
    @NSManaged public func removeFromChildrenFolders(_ value: FolderCD)

    @objc(addChildrenFolders:)
    @NSManaged public func addToChildrenFolders(_ values: NSSet)

    @objc(removeChildrenFolders:)
    @NSManaged public func removeFromChildrenFolders(_ values: NSSet)

}

// MARK: Generated accessors for documents
extension FolderCD {

    @objc(addDocumentsObject:)
    @NSManaged public func addToDocuments(_ value: DocumentCD)

    @objc(removeDocumentsObject:)
    @NSManaged public func removeFromDocuments(_ value: DocumentCD)

    @objc(addDocuments:)
    @NSManaged public func addToDocuments(_ values: NSSet)

    @objc(removeDocuments:)
    @NSManaged public func removeFromDocuments(_ values: NSSet)

}

extension FolderCD : Identifiable {

}
