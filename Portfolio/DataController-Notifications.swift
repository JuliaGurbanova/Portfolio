//
//  DataController-Notifications.swift
//  Portfolio
//
//  Created by Julia Gurbanova on 18.10.2023.
//

import Foundation
import UserNotifications

extension DataController {
    /// Checks authorization status and adds a reminder if it's granted.
    func addReminder(for issue: Issue) async -> Bool {
        do {
            let center = UNUserNotificationCenter.current()
            let settings = await center.notificationSettings()

            switch settings.authorizationStatus {
            case .notDetermined:
                let success = try await requestNotifications()

                if success {
                    try await placeReminders(for: issue)
                } else {
                    return false
                }

            case .authorized:
                try await placeReminders(for: issue)
            default:
                return false
            }

            return true
        } catch {
            return false
        }
    }

    /// Removes any pending notifications that are set for a specific issue.
    func removeReminders(for issue: Issue) {
        let center = UNUserNotificationCenter.current()
        let id = issue.objectID.uriRepresentation().absoluteString
        center.removePendingNotificationRequests(withIdentifiers: [id])
    }

    /// Requests notification authorization from iOS and returns whether the authorization was granted or not.
    private func requestNotifications() async throws -> Bool {
        let center = UNUserNotificationCenter.current()
        return try await center.requestAuthorization(options: [.alert, .sound])
    }

    /// Places notifications for a specific issue. Uses a repeating calendar trigger, specifying an hour and minute.
    private func placeReminders(for issue: Issue) async throws {
        let content = UNMutableNotificationContent()
        content.title = issue.issueTitle
        content.sound = .default

        if let issueContent = issue.content {
            content.subtitle = issueContent
        }

        let components = Calendar.current.dateComponents([.hour, .minute], from: issue.issueReminderTime)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        // trigger for testing purposes
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        let id = issue.objectID.uriRepresentation().absoluteString
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)

        return try await UNUserNotificationCenter.current().add(request)
    }
}
