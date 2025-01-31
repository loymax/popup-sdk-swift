//
//  PushNotificationManager.swift
//  SCExample
//
//  Created by lmxdev on 09.01.2025.
//

import UIKit
import SmartCommunications

protocol PushNotificationHandling {
    func registerForPushNotifications()
    func handleDeviceToken(_ deviceToken: Data)
    func handleRegistrationError(_ error: Error)
}

class PushNotificationManager: PushNotificationHandling {
    private let tokenManager: DeviceTokenManaging
    private let isClientAuthorized = SmartCommunicationsAPI.customHeaders.keys.contains("Authorization")
    
    init(tokenManager: DeviceTokenManaging) {
        self.tokenManager = tokenManager
    }
    
    /// Регистрация устройства для получения push-уведомлений
    func registerForPushNotifications() {
        if isClientAuthorized {
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
    /// Обработка успешной регистрации и передачи токена
    func handleDeviceToken(_ deviceToken: Data) {
        tokenManager.sendDeviceToken(deviceToken)
    }
    
    /// Обработка ошибок при регистрации
    func handleRegistrationError(_ error: Error) {
        print("Failed to register for remote notifications: \(error.localizedDescription)")
    }
}
