//
//  NotiViewController.swift
//  UIKitEveryThing
//
//  Created by 최범수 on 2025-03-19.
//

import UIKit

class NotiViewController: UIViewController {

    private let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "메시지가 여기에 표시됩니다"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("메시지 전송", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("🔵 [NotiViewController] viewDidLoad 호출됨")
        setupUI()
        setupNotificationObserver()
    }

    private func setupUI() {
        print("🔵 [NotiViewController] setupUI 호출됨")
        view.backgroundColor = .white
        title = "Notification Center 예제"

        view.addSubview(messageLabel)
        view.addSubview(sendButton)

        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            sendButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20),
            sendButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])

        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
    }

    private func setupNotificationObserver() {
        print("🔵 [NotiViewController] setupNotificationObserver 호출됨")
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleMessage(_:)),
            name: NSNotification.Name("NewMessage"),
            object: nil
        )
    }

    @objc private func sendButtonTapped() {
        print("🔵 [NotiViewController] sendButtonTapped 호출됨")
        // 새로운 메시지 전송
        NotificationCenter.default.post(
            name: NSNotification.Name("NewMessage"),
            object: nil,
            userInfo: ["message": "새로운 메시지가 도착했습니다! \(Date())"]
        )
    }

    @objc private func handleMessage(_ notification: Notification) {
        print("🔵 [NotiViewController] handleMessage 호출됨")
        if let message = notification.userInfo?["message"] as? String {
            print("🔵 [NotiViewController] 받은 메시지: \(message)")
            messageLabel.text = message
        }
    }

    deinit {
        print("🔵 [NotiViewController] deinit 호출됨")
        NotificationCenter.default.removeObserver(self)
    }
}
