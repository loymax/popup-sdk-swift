//
//  ViewController.swift
//  SCExample
//
//  Created by lmxdev on 19.12.2024.
//

import UIKit
import SmartCommunications

class LoginViewController: UIViewController {
    private let loginTextField = UITextField()
    private let passwordTextField = UITextField()
    private let loginButton = UIButton(type: .system)
    
    private let basePathLabel = UILabel()
    private let basePathTextField = UITextField()
    private let updateBasePathButton = UIButton(type: .system)
    
    private let currentBasePathLabel = UILabel()
    
    private lazy var pushNotificationManager: PushNotificationHandling = {
        let tokenService = DeviceTokenService()
        return PushNotificationManager(tokenManager: tokenService)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        updateCurrentBasePathLabel()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        loginTextField.placeholder = "Логин"
        passwordTextField.placeholder = "Пароль"
        passwordTextField.isSecureTextEntry = true
        
        loginButton.setTitle("Войти", for: .normal)
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        
        basePathLabel.text = "Установить SmartCommunicationsAPI.basePath URL"
        basePathLabel.font = .systemFont(ofSize: 14)
        
        basePathTextField.placeholder = "Введите base path url"
        basePathTextField.font = .systemFont(ofSize: 16)
        
        updateBasePathButton.setTitle("Обновить", for: .normal)
        updateBasePathButton.addTarget(self, action: #selector(updateBasePathTapped), for: .touchUpInside)
        
        currentBasePathLabel.font = .systemFont(ofSize: 12)
        currentBasePathLabel.numberOfLines = 0
        currentBasePathLabel.textColor = .darkGray
        
        let basePathInputStack = UIStackView(arrangedSubviews: [basePathTextField, updateBasePathButton])
        basePathInputStack.axis = .horizontal
        basePathInputStack.spacing = 8
        
        let basePathStack = UIStackView(arrangedSubviews: [basePathLabel, basePathInputStack, currentBasePathLabel])
        basePathStack.axis = .vertical
        basePathStack.spacing = 8
        
        let stackView = UIStackView(arrangedSubviews: [basePathStack, loginTextField, passwordTextField, loginButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            updateBasePathButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func updateCurrentBasePathLabel() {
        let basePath = SmartCommunicationsAPI.basePath
        if basePath.isEmpty {
            currentBasePathLabel.text = "Текущий base path url:\n[пустое значение]"
            currentBasePathLabel.textColor = .red
        } else {
            currentBasePathLabel.text = "Текущий base path url:\n\(basePath)"
            currentBasePathLabel.textColor = .darkGray
        }
    }
    
    @objc private func updateBasePathTapped() {
        if let newBasePath = basePathTextField.text, !newBasePath.isEmpty {
            SmartCommunicationsAPI.basePath = newBasePath
            UserDefaults.standard.set(newBasePath, forKey: "SCBasePath")
            updateCurrentBasePathLabel()
            basePathTextField.text = ""
        } else {
            showAlert(message: "Введите валидный base path")
        }
    }
    
    private func showSuccessAlert(message: String) {
        let alert = UIAlertController(title: "Успех", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc private func loginTapped() {
        guard let login = loginTextField.text, !login.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Введите логин и пароль")
            return
        }
        let attributes = GetAuthTokenRequestDataAttributes(username: login, password: password)
        let data = GetAuthTokenRequestData(attributes: attributes)
        let request = GetAuthTokenRequest(data: data)
        
        SmartCommunicationsAPI.AuthorizationAPI.getAuthToken(getAuthTokenRequest: request) { [weak self] result, error in
            // .generateAccessToken(generateAccessTokenRequest: request)
            DispatchQueue.main.async {
                switch result {
                case .typeAuthTokenResponse(let authTokenResponse):
                    if let token = authTokenResponse.data?.attributes?.accessToken {
                        SmartCommunicationsAPI.customHeaders = [
                            "Authorization" : token,
                            "Accept" : "application/json",
                            "Content-Type": "application/json"
                        ]
                        
                        // Рассчитываем дату истечения токена
                        let expirationDate = Date().addingTimeInterval(3600)
                        
                        // Сохраняем токен и дату истечения в UserDefaults
                        let userDefaults = UserDefaults.standard
                        userDefaults.set(token, forKey: "authToken")
                        userDefaults.set(expirationDate, forKey: "tokenExpirationDate")
                        userDefaults.synchronize()
                        
                        userDefaults.set(SmartCommunicationsAPI.customHeaders, forKey: "SCCustomHeaders")
                        userDefaults.synchronize()
                        
                        self?.updateNavigationBar(with: expirationDate)
                        self?.pushNotificationManager.registerForPushNotifications()
                    }
                    let subscriptionVC = SubscriptionViewController()
                    self?.navigationController?.pushViewController(subscriptionVC, animated: true)
                case .typeSMCErrorResponse(let sMCErrorResponse):
                    if let errorResponse = sMCErrorResponse.errors,
                       let details = errorResponse.first?.title {
                        self?.showAlert(message: details)
                    }
                case nil:
                    if error != nil {
                        self?.showAlert(message: error?.localizedDescription ?? "Ошибка входа")
                    }
                }
            }
        }
    }
    
    private func updateNavigationBar(with expirationDate: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        navigationItem.title = "Токен истекает: \(dateFormatter.string(from: expirationDate))"
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default))
        present(alert, animated: true)
    }
}
