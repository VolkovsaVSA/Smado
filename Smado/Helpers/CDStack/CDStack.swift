//
//  Persistence.swift
//  Smado
//
//  Created by Sergei Volkov on 04.02.2022.
//

import CoreData
import SwiftUI

class CDStack {
    static let shared = CDStack()
    private init() {}
    
    lazy var container: NSPersistentContainer = {

        let useCloudSync = UserDefaults.standard.bool(forKey: UDKeys.iCloudSync)

        let containerToUse: NSPersistentContainer?
        if useCloudSync {
            containerToUse = NSPersistentCloudKitContainer(name: "Smado")
        } else {
            containerToUse = NSPersistentContainer(name: "Smado")
        }

        guard let container = containerToUse else {
            fatalError("Couldn't get a container")
        }

        if let persistenContainer = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.VSA.Smado") {
            let storeURL = persistenContainer.appendingPathComponent("Smado.sqlite")
            let description = NSPersistentStoreDescription(url: storeURL)
            container.persistentStoreDescriptions = [description]
        }

        container.persistentStoreDescriptions.forEach {
            $0.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
            $0.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
            if useCloudSync {
                $0.cloudKitContainerOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: "iCloud.VSA.Smado")
            }
            
        }

        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("CDError: \(error.localizedDescription)")
            }
        })
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.automaticallyMergesChangesFromParent = true
        try? container.viewContext.setQueryGenerationFrom(.current)

        return container
    }()
    
    fileprivate func sendNotification(_ deletedObjects: [NotificationManager.DocNotifModel], _ updatedObjects: [NotificationManager.DocNotifModel], _ newObjects: [NotificationManager.DocNotifModel]) {
        NotificationManager.removeNotifications(objects: deletedObjects)
        
        if let udDate = UserDefaults.standard.object(forKey: UDKeys.allNotificationTime) as? Date,
           let hour = Calendar.current.dateComponents([.hour, .minute], from: udDate).hour,
           let minute = Calendar.current.dateComponents([.hour, .minute], from: udDate).minute
        {
            NotificationManager.sendNotification(objects: updatedObjects, timeNotification: (hour, minute))
            NotificationManager.sendNotification(objects: newObjects, timeNotification: (hour, minute))
        } else {
            NotificationManager.sendNotification(objects: updatedObjects, timeNotification: (12, 00))
            NotificationManager.sendNotification(objects: newObjects, timeNotification: (12, 00))
        }
    }
    
    func saveContext (context: NSManagedObjectContext) {
        
        DispatchQueue.main.async {
            
            var deletedObjects: [NotificationManager.DocNotifModel] = []
            var updatedObjects: [NotificationManager.DocNotifModel] = []
            var newObjects: [NotificationManager.DocNotifModel] = []
            
            if context.hasChanges {
                
                deletedObjects = context.deletedObjects
                    .compactMap {$0 as? DocumentCD}
                    .compactMap {NotificationManager.DocNotifModel(document: $0)}
                updatedObjects = context.updatedObjects
                    .compactMap {$0 as? DocumentCD}
                    .compactMap {NotificationManager.DocNotifModel(document: $0)}
                newObjects = context.updatedObjects
                    .compactMap {$0 as? DocumentCD}
                    .compactMap {NotificationManager.DocNotifModel(document: $0)}
                
                do {
                    try context.save()
                    self.sendNotification(deletedObjects, updatedObjects, newObjects)
                    
                } catch {
                    context.rollback()
                    let nserror = error as NSError
                    print("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }
        
    }
    
    func createCategory(title: String, icon: String) {
        let category = CategoryCD(context: container.viewContext)
        category.id = UUID()
        category.title = title
        category.image = icon
        category.craetedDate = Date()
    }
    func createDocument(category: CategoryCD,
                        title: String,
                        comment: String? = nil,
                        dateEnd: Date? = nil,
                        folder: FolderCD? = nil) -> DocumentCD {
        let document = DocumentCD(context: container.viewContext)
        document.id = UUID()
        document.parentCategory = category
        document.parentFolder = folder
        document.title = title
        document.comment = comment
        document.dateAdded = Date()
        document.dateEnd = dateEnd
        return document
    }
    func createImage(document: DocumentCD, fileName: String, data: Data) -> ImageCD {
        let image = ImageCD(context: container.viewContext)
        image.id = UUID()
        image.fileName = fileName
        image.parentDocument = document
        if let fileExtention = fileName.components(separatedBy: ".").last {
            image.fileExtention = fileExtention
        }
        image.data = data
        return image
    }
    
    func filterdocs(documents: FetchedResults<DocumentCD>, expiresStatus: ExpiredStatus) -> [FetchedResults<DocumentCD>.Element] {

        let date = Date()
        let calendar = Calendar.current
        let componentsToday = calendar.dateComponents([.year, .month, .weekOfMonth, .day], from: date)
        
        guard let todayYear = componentsToday.year,
              let todayMonth = componentsToday.month,
              let todayDay = componentsToday.day else {return []}
        
        switch expiresStatus {
                
            case .expired:
                return documents.filter {
                    guard let endDate = $0.dateEnd else {return false}
                    let componentsEnd = calendar.dateComponents([.year, .month, .weekOfMonth, .day], from: endDate)
                    
                    if let endYaer = componentsEnd.year,
                       let endMonth = componentsEnd.month,
                       let endDay = componentsEnd.day
                    {
                        return (todayYear >= endYaer) &&
                            (todayMonth >= endMonth) &&
                            (todayDay > endDay)
                    } else {
                        return false
                    }
                    
                }.sorted {$0.dateEnd ?? Date() < $1.dateEnd ?? Date()}
                
            case .today:
                return documents.filter { document in
                    if let docDate = document.dateEnd {
                        let componentsDoc = calendar.dateComponents([.year, .month, .weekOfMonth, .day], from: docDate)
                        return (componentsToday.year == componentsDoc.year) &&
                            (componentsToday.month == componentsDoc.month) &&
                            (componentsToday.day == componentsDoc.day)
                    } else {
                        return false
                    }
                }.sorted {$0.dateEnd ?? Date() < $1.dateEnd ?? Date()}
                
            case .thisWeek:
                return documents.filter { document in
                    if let docDate = document.dateEnd {
                        return Date().addOrSubtructDay(day: 8) >= docDate
                        && Date().addOrSubtructDay(day: 1) <= docDate
                    } else {
                        return false
                    }
                }.sorted {$0.dateEnd ?? Date() < $1.dateEnd ?? Date()}
                
            case .thisMonth:
                return documents.filter { document in
                    if let docDate = document.dateEnd {
                        return Date().addOrSubtructDay(day: 31) >= docDate
                        && Date().addOrSubtructDay(day: 1) <= docDate
                    } else {
                        return false
                    }
                }.sorted {$0.dateEnd ?? Date() < $1.dateEnd ?? Date()}
        }
    }
    
}


