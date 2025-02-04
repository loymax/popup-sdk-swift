//
//  DeviceTokenService.swift
//  SCExample
//
//  Created by lmxdev on 09.01.2025.
//

import Foundation
import SmartCommunications

protocol DeviceTokenManaging {
    func sendDeviceToken(_ token: Data)
}

public class DeviceTokenService: DeviceTokenManaging {
    private let isTestMode: Bool
    var logHandler: ((String) -> Void)? // Для передачи логов в UI

    init(isTestMode: Bool = false) {
        self.isTestMode = isTestMode
    }
    
    public func sendDeviceToken(_ token: Data) {
        let tokenString = token.map { String(format: "%02.2hhx", $0) }.joined()

        logHandler?("Отправка токена: \(tokenString)\nClientID: \(UserManagement.shared.getClientId())")

        let contacts = SmartCommunicationsAPI.AddCustomerTokenRequestDataAttributesContactsInner(
            type: "push",
            value: tokenString,
            device: "apple"
        )
        let attributes = SmartCommunicationsAPI.AddCustomerTokenRequestDataAttributes(contacts: [contacts])
        let requestData = SmartCommunicationsAPI.AddCustomerTokenRequestData(attributes: attributes)
        let request = SmartCommunicationsAPI.AddCustomerTokenRequest(data: requestData)

        SmartCommunicationsAPI.CustomerAPI.addCustomerToken(id: UserManagement.shared.getClientId(), addCustomerTokenRequest: request) { data, error in
            if let error = error {
                self.logHandler?("Ошибка отправки токена: \(error.localizedDescription)")
            } else {
                self.logHandler?("Токен успешно отправлен для ClientID: \(UserManagement.shared.getClientId())")
            }
        }
    }
    
    // Firebase token
    public func sendFCMToken(_ fcmToken: String?) {
        guard let token = fcmToken else {
            self.logHandler?("Ошибка получения токена для Firebase")
            return
        }

        logHandler?("Отправка токена: \(token)\nClientID: \(UserManagement.shared.getClientId())")

        let contacts = SmartCommunicationsAPI.AddCustomerTokenRequestDataAttributesContactsInner(
            type: "push",
            value: token,
            device: "apple"
        )
        let attributes = SmartCommunicationsAPI.AddCustomerTokenRequestDataAttributes(contacts: [contacts])
        let requestData = SmartCommunicationsAPI.AddCustomerTokenRequestData(attributes: attributes)
        let request = SmartCommunicationsAPI.AddCustomerTokenRequest(data: requestData)

        SmartCommunicationsAPI.CustomerAPI.addCustomerToken(id: UserManagement.shared.getClientId(), addCustomerTokenRequest: request) { result, error in
            if let error = error {
                self.logHandler?("Ошибка отправки токена в Firebase: \(error.localizedDescription)")
            } else {
                self.logHandler?("Токен успешно отправлен в Firebase для ClientID: \(UserManagement.shared.getClientId())")
            }
        }
    }
}
