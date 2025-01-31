//
//  AppDelegate+FirebaseMessaging.swift
//  SCExample
//
//  Created by lmxdev on 13.01.2025.
//

import UIKit
import FirebaseMessaging
import SmartCommunications

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // Получение уведомлений при активном приложении
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("Пользователю поступило уведомление: \(notification.request.identifier)")
        let requestInner = SmartCommunicationsAPI.LogPushEventRequestDataInner(type: "event", messageId: notification.request.identifier, externalClientId: UserManagement.shared.getClientId())
        let request = SmartCommunicationsAPI.LogPushEventRequest(data: [requestInner])
        SmartCommunicationsAPI.CommunicationAPI.logPushEvent(type: "push", logPushEventRequest: request) { response, error in
            if let error = error {
                print("Failed to log push event: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.showAlert(message: "Failed to log push event: \(error.localizedDescription)")
                }
            } else if let response = response {
                print("Successfully logged push event: \(response)")
            }
        }
        completionHandler([.banner, .sound, .badge])
    }
    
    // Обработка уведомлений при нажатии
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        print("Пользователь нажал на уведомление: \(response.notification.request.content.userInfo)")
        
        let requestInner = SmartCommunicationsAPI.LogPushEventRequestDataInner(type: "event", messageId: "client-tapped-notification", externalClientId: UserManagement.shared.getClientId())
        let request = SmartCommunicationsAPI.LogPushEventRequest(data: [requestInner])
        SmartCommunicationsAPI.CommunicationAPI.logPushEvent(type: "push", logPushEventRequest: request) { response, error in
            if let error = error {
                print("Failed to log push event: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.showAlert(message: "Failed to log push event: \(error.localizedDescription)")
                }
            } else if let response = response {
                print("Successfully logged push event: \(response)")
            }
        }
        completionHandler()
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("FCM Token: \(fcmToken ?? "")")
        let tokenService = DeviceTokenService()
        tokenService.logHandler = { [weak self] logMessage in
            print(logMessage)
            self?.showAlert(message: logMessage)
        }
        tokenService.sendFCMToken(fcmToken)
    }
}

