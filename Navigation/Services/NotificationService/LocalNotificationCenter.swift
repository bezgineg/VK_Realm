//
//  LocalNotificationCenter.swift
//  Navigation
//
//  Created by Bezgin Evgenii on 9/10/21.
//  Copyright © 2021 Bezgin Evgenii. All rights reserved.
//

import UIKit
import UserNotifications

protocol NotificationCenterService {
    func registerForLatestUpdatesIfPossible()
}

final class LocalNotificationCenter: NSObject, NotificationCenterService {
    
    // MARK: - Public Methods
    
    public func registerForLatestUpdatesIfPossible() {
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.provisional, .alert, .badge, .sound]
        ) { granted, error in
            if granted {
                self.scheduleNotification()
            } else {
                print(error?.localizedDescription ?? "Some error")
            }
        }
    }
    
    // MARK: - Private Methods

    private func scheduleNotification() {
        registerUpdatesCategory()
        
        let content = UNMutableNotificationContent()
        content.title = "Новое уведомление"
        content.body = "Посмотрите последние обновления"
        content.sound = .default
        content.categoryIdentifier = "updates"
        
        UNUserNotificationCenter.current().delegate = self
        
        var dateComponents = DateComponents()
        dateComponents.hour = 19
        dateComponents.minute = 00
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    private func registerUpdatesCategory() {
        let actions = UNNotificationAction(identifier: "tapAction", title: "Rate app", options: [])
        let category = UNNotificationCategory(identifier: "updates", actions: [actions], intentIdentifiers: [])
    
        UNUserNotificationCenter.current().setNotificationCategories([category])
    }
}

extension LocalNotificationCenter: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
         switch response.actionIdentifier {
         case "tapAction":
            print("Thanks for 5 stars")
         case UNNotificationDefaultActionIdentifier:
            print("Default Identifier")
         default:
            break
        }
        completionHandler()
    }
}
