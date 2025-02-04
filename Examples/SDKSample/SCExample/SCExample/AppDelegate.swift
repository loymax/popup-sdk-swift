//
//  AppDelegate.swift
//  SCExample
//
//  Created by lmxdev on 19.12.2024.
//

import UIKit
import Firebase
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    private lazy var pushNotificationManager: PushNotificationHandling = {
        let tokenService = DeviceTokenService()
        return PushNotificationManager(tokenManager: tokenService)
    }()
    
    lazy var tokenService: DeviceTokenService = {
        return DeviceTokenService()
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        // Настройка уведомлений
        UNUserNotificationCenter.current().delegate = self
        requestNotificationAuthorization(application)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    /// Успешная регистрация для push-уведомлений
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        pushNotificationManager.handleDeviceToken(deviceToken)
        
        Messaging.messaging().apnsToken = deviceToken
    }
    
    /// Ошибка регистрации для push-уведомлений
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        pushNotificationManager.handleRegistrationError(error)
    }
    
    func requestNotificationAuthorization(_ application: UIApplication) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Ошибка авторизации уведомлений: \(error.localizedDescription)")
                self.showAlert(message: "Ошибка авторизации уведомлений")
            }
            print("Разрешение на уведомления: \(granted)")
            self.showAlert(message: "Разрешение на уведомления: \(granted ? "Есть" : "Нет")")
        }
        application.registerForRemoteNotifications()
    }
    
    func showAlert(message: String) {
        guard let rootViewController = window?.rootViewController else { return }
        let alert = UIAlertController(title: "Результат отправки токена", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        rootViewController.present(alert, animated: true, completion: nil)
    }
}
