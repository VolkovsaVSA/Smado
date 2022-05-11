//
//  NotificationManager.swift
//  Smado
//
//  Created by Sergei Volkov on 12.04.2022.
//

import Foundation
import UserNotifications
import CoreData

class NotificationManager {
    private init() {}
    static private let center = UNUserNotificationCenter.current()
    
    static func requestAuthorization(completion: @escaping  (Bool) -> Void) {
        center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            completion(success)
        }
    }
    
    
    static func removeAllPendingNotifications() {
        center.removeAllPendingNotificationRequests()
    }
    static func removeNotifications(objects: [NotificationManager.DocNotifModel]) {
        var ids = [String]()
        objects.forEach { object in
            ids.append(object.id + ExpiredStatus.today.rawValue)
            ids.append(object.id + ExpiredStatus.thisWeek.rawValue)
            ids.append(object.id + ExpiredStatus.thisMonth.rawValue)
        }
        center.removePendingNotificationRequests(withIdentifiers: ids)
    }
    static func removeNotifications(identifires: [String]) {
        center.removePendingNotificationRequests(withIdentifiers: identifires)
    }

    static func sendNotification(objects: [NotificationManager.DocNotifModel],
                                 timeNotification: (hour: Int, minute: Int)) {
        
        objects.forEach { object in
            
            let content = UNMutableNotificationContent()
            content.title = "Document expires"
            content.subtitle = "Document \(object.title) expires today"
            content.sound = UNNotificationSound.default
            
            if object.notifToday {
                sendRequset(requestId: object.id + ExpiredStatus.today.rawValue,
                            date: object.endDate,
                            time: timeNotification,
                            content: content)
            } else {
                removeNotifications(identifires: [object.id + ExpiredStatus.today.rawValue])
            }
            if object.notifWeek {
                let startOfDay = Calendar.current.startOfDay(for: object.endDate)
                let weekBeforeStartOfDay = startOfDay - (60*60*24)*7
                content.subtitle = "Document \(object.title) in a week \(object.endDate.formatted(date: .abbreviated, time: .omitted))"
                sendRequset(requestId: object.id + ExpiredStatus.thisWeek.rawValue,
                            date: weekBeforeStartOfDay,
                            time: timeNotification,
                            content: content)
            } else {
                removeNotifications(identifires: [object.id + ExpiredStatus.thisWeek.rawValue])
            }
            if object.notifMonth {
                let startOfDay = Calendar.current.startOfDay(for: object.endDate)
                let monthBeforeStartOfDay = startOfDay - (60*60*24)*30
                content.subtitle = "Document \(object.title) in one month \(object.endDate.formatted(date: .abbreviated, time: .omitted))"
                sendRequset(requestId: object.id + ExpiredStatus.thisMonth.rawValue,
                            date: monthBeforeStartOfDay,
                            time: timeNotification,
                            content: content)
            } else {
                removeNotifications(identifires: [object.id + ExpiredStatus.thisMonth.rawValue])
            }

            
            
            func sendRequset(requestId: String,
                             date: Date,
                             time: (hour: Int, minute: Int),
                             content: UNMutableNotificationContent
            ) {
                let calendar = Calendar.current
                var dateComponents = DateComponents(calendar: calendar,
                                                    timeZone: TimeZone.current,
                                                    year: calendar.component(.year, from: date),
                                                    month: calendar.component(.month, from: date),
                                                    day: calendar.component(.day, from: date),
                                                    hour: calendar.component(.hour, from: date),
                                                    minute: calendar.component(.minute, from: date)
                )
                dateComponents.hour = time.hour
                dateComponents.minute = time.minute
                let calendarTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
                let request = UNNotificationRequest(identifier: requestId, content: content, trigger: calendarTrigger)
                center.add(request)
            }
            
        }
        
        
    }
}


extension NotificationManager {
    
    struct DocNotifModel {
        var id: String
        var title: String
        var endDate: Date
        var notifToday: Bool
        var notifWeek: Bool
        var notifMonth: Bool
        
        init?(document: DocumentCD) {
            guard let id = document.id?.uuidString,
                  let title = document.title,
                  let endDate = document.dateEnd else {return nil}
            self.id = id
            self.title = title
            self.endDate = endDate
            self.notifToday = document.notifToday
            self.notifWeek = document.notifWeek
            self.notifMonth = document.notifMonth
        }
    }
    
}
