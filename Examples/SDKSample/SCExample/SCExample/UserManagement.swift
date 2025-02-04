//
//  UserManagement.swift
//  SCExample
//
//  Created by lmxdev on 09.01.2025.
//

import Foundation

class UserManagement {
    static let shared = UserManagement()
    
    // Default test value
    private var clientId: String = "АгентаНФ"
    
    private init() {}
    
    func getClientId() -> String {
        return clientId
    }
    
    func setClientId(_ newClientId: String) {
        clientId = newClientId
    }
    
    /// Метод для генерации фейкового токена на основе clientId
    func getFakeToken() -> String {
        return clientId
            .applyingTransform(.toLatin, reverse: false)? // Транслитерация в латиницу
            .replacingOccurrences(of: " ", with: "") // Удаление пробелов
            .prefix(10) // Ограничение длины
            .appending(UUID().uuidString.prefix(10)) ?? "defaultFakeToken" // Добавление уникальной части
    }
}
