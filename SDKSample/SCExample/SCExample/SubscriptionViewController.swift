//
//  ViewController.swift
//  SCExample
//
//  Created by lmxdev on 19.12.2024.
//

import UIKit
import SmartCommunications

class SubscriptionViewController: UIViewController {
    private var subscriptions: [SubscriptionCategory: Bool] = [:] // Категория: Подписан/Не подписан
    private var permissions: [String: Bool] = [:] // Тип: Разрешение (true - разрешено, false - запрещено)
    private let tableView = UITableView()
    
    private let clientIdTextField = UITextField()
    private let clientIdLabel = UILabel()
    private let updateButton = UIButton(type: .system)
    private let instructionLabel = UILabel()
    private let explanationLabel = UILabel()
    private let tokenLabel = UILabel()
    private let logTextView = UITextView()
    private let modeSwitch = UISwitch()
    private let modeLabel = UILabel()
    private let pushSwitch = UISwitch()
    private let pushSwitchLabel = UILabel()
    
    private var tableViewHeightConstraint: NSLayoutConstraint!
    
    private var isTestMode = true
    private lazy var tokenService = DeviceTokenService(isTestMode: isTestMode)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateNavigationBar()
        setupTableView()
        setupLogger()
        setupPushNotificationLogging()
        fetchSubscriptions()
        fetchDeviceNotificationPermissions()
        fetchNotificationPermissions()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableViewHeightConstraint.constant = tableView.contentSize.height
        view.layoutIfNeeded()
    }
    
    private func setupLogger() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        paragraphStyle.paragraphSpacing = 8
        paragraphStyle.alignment = .left
        
        Logger.shared.addObserver { [weak self] message, isRequest in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                let timestamp = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .medium)
                let logMessage = "[\(timestamp)] \(isRequest ? "REQUEST" : "RESPONSE")\n\(message)\n\n"
                
                let attributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont(name: "Courier", size: 12) ?? UIFont.systemFont(ofSize: 12),
                    .foregroundColor: UIColor.darkGray,
                    .paragraphStyle: paragraphStyle
                ]
                
                let attributedLog = NSAttributedString(string: logMessage, attributes: attributes)
                let currentText = self.logTextView.attributedText ?? NSAttributedString()
                let updatedText = NSMutableAttributedString(attributedString: currentText)
                updatedText.append(attributedLog)
                
                self.logTextView.attributedText = updatedText
                let bottomRange = NSRange(location: updatedText.length - 1, length: 1)
                self.logTextView.scrollRangeToVisible(bottomRange)
            }
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        clientIdLabel.text = "Текущий ClientId: " + UserManagement.shared.getClientId()
        clientIdLabel.translatesAutoresizingMaskIntoConstraints = false
        
        clientIdTextField.placeholder = "Введите новый ClientId"
        clientIdTextField.borderStyle = .roundedRect
        clientIdTextField.translatesAutoresizingMaskIntoConstraints = false
        clientIdTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        updateButton.setTitle("Обновить", for: .normal)
        updateButton.addTarget(self, action: #selector(updateButtonTapped), for: .touchUpInside)
        updateButton.translatesAutoresizingMaskIntoConstraints = false
        updateButton.backgroundColor = .systemBlue
        updateButton.setTitleColor(.white, for: .normal)
        updateButton.layer.cornerRadius = 8
        updateButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        let clientIdStack = UIStackView(arrangedSubviews: [clientIdTextField, updateButton])
        clientIdStack.axis = .horizontal
        clientIdStack.spacing = 8
        clientIdStack.alignment = .fill
        clientIdStack.translatesAutoresizingMaskIntoConstraints = false
        
        pushSwitchLabel.text = "Пуш-уведомления"
        pushSwitchLabel.font = .systemFont(ofSize: 14)
        pushSwitchLabel.translatesAutoresizingMaskIntoConstraints = false
        
        pushSwitch.isOn = permissions["push"] ?? false
        pushSwitch.addTarget(self, action: #selector(pushSwitchChanged(_:)), for: .valueChanged)
        pushSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        let pushStack = UIStackView(arrangedSubviews: [pushSwitchLabel, pushSwitch])
        pushStack.axis = .horizontal
        pushStack.spacing = 8
        pushStack.alignment = .center
        pushStack.translatesAutoresizingMaskIntoConstraints = false
        
        explanationLabel.text = "Эмуляция токена для тестирования. Реальный токен устройства использовать не требуется."
        explanationLabel.numberOfLines = 0
        explanationLabel.font = .systemFont(ofSize: 14)
        explanationLabel.textColor = .darkGray
        explanationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        tokenLabel.text = "Текущий токен для APNS: \(UserManagement.shared.getFakeToken())"
        tokenLabel.numberOfLines = 0
        tokenLabel.font = .systemFont(ofSize: 14)
        tokenLabel.textColor = .darkGray
        tokenLabel.translatesAutoresizingMaskIntoConstraints = false
        
        modeLabel.text = "Эмуляция токенов"
        modeLabel.font = .systemFont(ofSize: 14)
        modeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        modeSwitch.isOn = true
        modeSwitch.addTarget(self, action: #selector(modeSwitchChanged(_:)), for: .valueChanged)
        modeSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        logTextView.isEditable = false
        logTextView.font = UIFont(name: "Courier", size: 12)
        logTextView.textColor = .darkGray
        logTextView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        logTextView.layer.cornerRadius = 8
        logTextView.translatesAutoresizingMaskIntoConstraints = false
        
        let modeStack = UIStackView(arrangedSubviews: [modeLabel, modeSwitch])
        modeStack.axis = .horizontal
        modeStack.spacing = 8
        modeStack.translatesAutoresizingMaskIntoConstraints = false
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        let contentStackView = UIStackView(arrangedSubviews: [
            clientIdLabel,
            clientIdStack,
            pushStack,
            explanationLabel,
            tokenLabel,
            tableView,
            instructionLabel,
            logTextView
        ])
        contentStackView.axis = .vertical
        contentStackView.spacing = 16
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentStackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 15),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])
        
        tableViewHeightConstraint = tableView.heightAnchor.constraint(equalToConstant: 0)
        tableViewHeightConstraint.isActive = true
        
        logTextView.heightAnchor.constraint(equalToConstant: 400).isActive = true
    }
    
    private func setupTableView() {
        instructionLabel.text = "Нажмите на ячейку, чтобы изменить статус подписки"
        instructionLabel.numberOfLines = 0
        instructionLabel.font = .systemFont(ofSize: 16)
        instructionLabel.textColor = .label
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
    }
    
    @objc private func updateButtonTapped() {
        if let newClientId = clientIdTextField.text, !newClientId.isEmpty {
            UserManagement.shared.setClientId(newClientId)
            clientIdLabel.text = "Текущий ClientId: " + UserManagement.shared.getClientId()
            tokenLabel.text = "Текущий токен для APNS: \(UserManagement.shared.getFakeToken())"
            let clientToken = UserManagement.shared.getFakeToken().data(using: .utf8)!
            // tokenService.sendDeviceToken(clientToken)
            tokenService.sendFCMToken(UserManagement.shared.getFakeToken())
            fetchSubscriptions()
            clientIdTextField.text = ""
            view.endEditing(true)
        }
    }
    
    @objc private func modeSwitchChanged(_ sender: UISwitch) {
        isTestMode = sender.isOn
        tokenService = DeviceTokenService(isTestMode: isTestMode)
        setupPushNotificationLogging()
        tokenLabel.text = isTestMode ? "Текущий токен для APNS: \(UserManagement.shared.getFakeToken())" : "Реальный токен устройства."
    }
    
    @objc private func pushSwitchChanged(_ sender: UISwitch) {
        if sender.isOn {
            // Запрашиваем разрешения на уведомления
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { [weak self] granted, error in
                DispatchQueue.main.async {
                    if granted {
                        self?.pushSwitch.isOn = true
                        self?.updateNotificationPermission(for: "push", to: true)
                    } else {
                        self?.pushSwitch.isOn = false
                        self?.showPermissionAlert()
                    }
                }
            }
        } else {
            // Отключаем уведомления
            updateNotificationPermission(for: "push", to: false)
        }
    }
    
    private func showPermissionAlert() {
        let alert = UIAlertController(
            title: "Разрешение на уведомления",
            message: "Вы отключили уведомления. Чтобы включить их, перейдите в настройки приложения.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        
        alert.addAction(UIAlertAction(title: "Настройки", style: .default) { _ in
            if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                if UIApplication.shared.canOpenURL(appSettings) {
                    UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
                }
            }
        })
        
        present(alert, animated: true)
    }
    
    private func setupPushNotificationLogging() {
        tokenService.logHandler = { [weak self] log in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.logTextView.text.append("\(log)\n")
                
                let bottom = NSRange(location: self.logTextView.text.count, length: 0)
                self.logTextView.scrollRangeToVisible(bottom)
            }
        }
    }
    
    private func fetchSubscriptions() {
        let clientId = UserManagement.shared.getClientId()
        
        guard !clientId.isEmpty else {
            showAlert(message: "Client ID отсутствует.")
            return
        }
        
        SmartCommunicationsAPI.CustomerAPI.getCustomerSubscriptionCategories(id: clientId) { [weak self] response, error in
            guard let self = self else { return }
            
            if let error = error {
                self.showAlert(message: "Ошибка получения подписок: \(error.localizedDescription)")
                return
            }
            
            switch response {
            case .typeCustomerSubscriptionCategories(let customerSubscriptionCategories):
                guard let data = customerSubscriptionCategories.data else {
                    self.showAlert(message: "Данные о подписках отсутствуют")
                    return
                }
                
                if let firstCategory = data.first,
                   let attributes = firstCategory.attributes {
                    self.subscriptions = [
                        .email: attributes.statusEmail == "Y",
                        .sms: attributes.statusSms == "Y",
                        .push: attributes.statusPush == "Y",
                        .messengerTelegram: false,
                        .messengerWhatsapp: false
                    ]
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    
                    self.tableViewHeightConstraint.constant = self.tableView.contentSize.height
                    self.view.layoutIfNeeded()
                }
            case .typeSMCErrorResponse(let sMCErrorResponse):
                if let errorResponse = sMCErrorResponse.errors,
                   let details = errorResponse.first?.title {
                    self.showAlert(message: details)
                }
            case nil:
                self.showAlert(message: "Данные о подписках отсутствуют")
            }
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default))
        present(alert, animated: true)
    }
    
    private func updateNavigationBar() {
        let title = "Категории подписок"
        var subtitle = ""
        if let expirationDate = UserDefaults.standard.object(forKey: "tokenExpirationDate") as? Date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
            subtitle = "Токен действителен до: \(dateFormatter.string(from: expirationDate))"
        }
        
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 17, weight: .bold),
            .foregroundColor: UIColor.label
        ]
        
        let subtitleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 13, weight: .regular),
            .foregroundColor: UIColor.secondaryLabel
        ]
        
        let attributedTitle = NSMutableAttributedString(string: title + "\n", attributes: titleAttributes)
        attributedTitle.append(NSAttributedString(string: subtitle, attributes: subtitleAttributes))
        
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.attributedText = attributedTitle
        
        self.navigationItem.titleView = label
    }
    
    func appendLog(_ message: String, isRequest: Bool) {
        let formattedMessage = NSMutableAttributedString()
        
        let timestamp = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .medium)
        let timestampAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.systemGray]
        formattedMessage.append(NSAttributedString(string: "[\(timestamp)]\n", attributes: timestampAttributes))
        
        let header = isRequest ? "REQUEST\n" : "RESPONSE\n"
        let headerAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: isRequest ? UIColor.systemBlue : UIColor.systemGreen,
            .font: UIFont.boldSystemFont(ofSize: 14)
        ]
        formattedMessage.append(NSAttributedString(string: header, attributes: headerAttributes))
        
        let bodyAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.label,
            .font: UIFont(name: "Courier", size: 12)
        ]
        formattedMessage.append(NSAttributedString(string: message + "\n", attributes: bodyAttributes))
        
        let separatorAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.systemGray]
        formattedMessage.append(NSAttributedString(string: "------------------------------\n", attributes: separatorAttributes))
        
        // Append to TextView
        DispatchQueue.main.async {
            let currentText = self.logTextView.attributedText ?? NSAttributedString()
            let updatedText = NSMutableAttributedString(attributedString: currentText)
            updatedText.append(formattedMessage)
            self.logTextView.attributedText = updatedText
            
            // Scroll to bottom
            let range = NSRange(location: updatedText.length - 1, length: 1)
            self.logTextView.scrollRangeToVisible(range)
        }
    }
    
    private func fetchDeviceNotificationPermissions() {
        UNUserNotificationCenter.current().getNotificationSettings { [weak self] settings in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch settings.authorizationStatus {
                case .authorized, .provisional:
                    self.pushSwitch.isOn = true
                case .denied, .notDetermined:
                    self.pushSwitch.isOn = false
                @unknown default:
                    self.pushSwitch.isOn = false
                }
            }
        }
    }

    private func fetchNotificationPermissions() {
        let clientId = UserManagement.shared.getClientId()
        
        SmartCommunicationsAPI.CustomerAPI.getCustomerNotificationStatus(id: clientId) { [weak self] response, error in
            guard let self = self else { return }
            if let error = error {
                self.showAlert(message: "Ошибка получения статуса уведомлений: \(error.localizedDescription)")
                return
            }
            
            switch response {
            case .typeCustomerNotificationStatus(let customerNotificationStatus):
                guard let data = customerNotificationStatus.data else {
                    self.showAlert(message: "Данные о разрешениях отсутствуют")
                    return
                }
                
                let channels = self.mapToNotificationChannels(from: data)
                self.updatePermissions(with: channels)
            case .typeSMCErrorResponse(let sMCErrorResponse):
                if let errorResponse = sMCErrorResponse.errors,
                   let details = errorResponse.first?.title {
                    self.showAlert(message: details)
                }
            case nil:
                self.showAlert(message: "Данные о разрешениях отсутствуют")
            }
            
            
        }
    }

    private func mapToNotificationChannels(from data: [SmartCommunicationsAPI.CustomerNotificationStatusDataInner]) -> [NotificationChannel] {
        return data.map { item -> NotificationChannel in
            NotificationChannel(
                type: item.attributes?.type ?? "",
                value: item.attributes?.value ?? 0
            )
        }
    }

    private func updatePermissions(with channels: [NotificationChannel]) {
        permissions = channels.reduce(into: [String: Bool]()) { dict, channel in
            dict[channel.type] = (channel.value == 1)
        }
        DispatchQueue.main.async {
            // self.pushSwitch.isOn = self.permissions["push"] ?? false
            self.tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
        }
    }
    
    private func updateNotificationPermission(for type: String, to status: Bool) {
        let clientId = UserManagement.shared.getClientId()
        guard !clientId.isEmpty else {
            showAlert(message: "Client ID отсутствует.")
            return
        }
        
        let permission = status ? "Y" : "N"
        let attributes = SmartCommunicationsAPI.SetCustomerNotificationStatusRequestDataAttributes(push: permission)
        let requestData = SmartCommunicationsAPI.SetCustomerNotificationStatusRequestData(attributes: attributes)
        let request = SmartCommunicationsAPI.SetCustomerNotificationStatusRequest(data: requestData)
        
        SmartCommunicationsAPI.CustomerAPI.setCustomerNotificationStatus(id: clientId, setCustomerNotificationStatusRequest: request) { [weak self] response, error in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.fetchNotificationPermissions()
            }
        }
    }
}

// MARK: - UITableView DataSource & Delegate
extension SubscriptionViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 // One for subscriptions, one for permissions
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return subscriptions.count
        } else {
            return permissions.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Подписки"
        } else {
            return "Разрешения на уведомления"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if cell.detailTextLabel == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        }
        
        if indexPath.section == 0 {
            // Subscriptions
            let category = Array(subscriptions.keys)[indexPath.row]
            let isSubscribed = subscriptions[category] ?? false
            cell.textLabel?.text = category.rawValue
            cell.detailTextLabel?.text = isSubscribed ? "Подписан" : "Не подписан"
            cell.detailTextLabel?.textColor = isSubscribed ? .systemGreen : .systemRed
        } else {
            // Permissions
            let permissionType = Array(permissions.keys)[indexPath.row]
            let isPermissionGranted = permissions[permissionType] ?? false
            cell.textLabel?.text = permissionType
            cell.detailTextLabel?.text = isPermissionGranted ? "Разрешено" : "Запрещено"
            cell.detailTextLabel?.textColor = isPermissionGranted ? .systemGreen : .systemRed
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            // Subscriptions
            let category = Array(subscriptions.keys)[indexPath.row]
            let newStatus = !(subscriptions[category] ?? false)
            updateSubscription(category, to: newStatus)
        }
    }
    
    private func updateSubscription(_ category: SubscriptionCategory, to status: Bool) {
        let clientId = UserManagement.shared.getClientId()
        
        let mailingCode = SmartCommunicationsAPI.ModifySubscriptionRequestDataAttributesCategoriesMailingCode(
            email: category == .email ? (status ? "Y" : "N") : nil,
            sms: category == .sms ? (status ? "Y" : "N") : nil,
            push: category == .push ? (status ? "Y" : "N") : nil,
            messengerTelegram: category == .messengerTelegram ? (status ? "Y" : "N") : nil,
            messengerWhatsapp: category == .messengerWhatsapp ? (status ? "Y" : "N") : nil
        )
        
        let categories = SmartCommunicationsAPI.ModifySubscriptionRequestDataAttributesCategories(mailingCode: mailingCode)
        let attributes = SmartCommunicationsAPI.ModifySubscriptionRequestDataAttributes(categories: categories)
        let requestData = SmartCommunicationsAPI.ModifySubscriptionRequestData(attributes: attributes)
        let request = SmartCommunicationsAPI.ModifySubscriptionRequest(data: requestData)
        
        SmartCommunicationsAPI.CustomerAPI.modifyCustomerSubscriptionCategories(id: clientId, modifySubscriptionRequest: request) { [weak self] response, error in
            guard let self = self else { return }
            let isModified = response?.data?.attributes?.status == "success"
            if let error = error {
                self.showAlert(message: "Ошибка: \(error.localizedDescription)")
                return
            }
            
            DispatchQueue.main.async {
                self.subscriptions[category] = status
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: - Модели
enum SubscriptionCategory: String {
    case email = "email"
    case sms = "sms"
    case push = "push"
    case messengerTelegram = "Telegram"
    case messengerWhatsapp = "Whatsapp"
}

struct NotificationChannel: Codable {
    let type: String
    let value: Int // 1 - разрешено, 0 - запрещено
}

struct NotificationChannelResponse: Codable {
    let data: [NotificationChannel]
}
