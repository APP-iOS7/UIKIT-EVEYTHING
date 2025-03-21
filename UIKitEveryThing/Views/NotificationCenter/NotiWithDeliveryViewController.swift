import UIKit

// 택배 정보 class
class DeliveryInfo {
    let trackingNumber: String
    let sender: String
    let receiver: String
    let status: DeliveryStatus
    let timestamp: Date

    enum DeliveryStatus: String {
        case pickedUp = "수거완료"
        case inTransit = "배송중"
        case delivered = "배송완료"
    }

    init(
        trackingNumber: String, sender: String, receiver: String, status: DeliveryStatus,
        timestamp: Date
    ) {
        self.trackingNumber = trackingNumber
        self.sender = sender
        self.receiver = receiver
        self.status = status
        self.timestamp = timestamp
        print("🟣 [DeliveryInfo] 초기화됨 - 운송장번호: \(trackingNumber), 상태: \(status.rawValue)")
    }
}

class NotiWithDeliveryViewController: UIViewController {

    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "택배 상태가 여기에 표시됩니다"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let trackingNumberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "운송장 번호 입력"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let updateStatusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("상태 업데이트", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("🟣 [NotiWithDeliveryViewController] viewDidLoad 호출됨")
        setupUI()
        setupNotificationObserver()
    }

    private func setupUI() {
        print("🟣 [NotiWithDeliveryViewController] setupUI 호출됨")
        view.backgroundColor = .white
        title = "택배 알림 시스템"

        view.addSubview(statusLabel)
        view.addSubview(trackingNumberTextField)
        view.addSubview(updateStatusButton)

        NSLayoutConstraint.activate([
            statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statusLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            trackingNumberTextField.topAnchor.constraint(
                equalTo: statusLabel.bottomAnchor, constant: 20),
            trackingNumberTextField.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: 20),
            trackingNumberTextField.trailingAnchor.constraint(
                equalTo: view.trailingAnchor, constant: -20),

            updateStatusButton.topAnchor.constraint(
                equalTo: trackingNumberTextField.bottomAnchor, constant: 10),
            updateStatusButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])

        updateStatusButton.addTarget(
            self, action: #selector(updateStatusButtonTapped), for: .touchUpInside)
    }

    private func setupNotificationObserver() {
        print("🟣 [NotiWithDeliveryViewController] setupNotificationObserver 호출됨")
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleDeliveryUpdate(_:)),
            name: NSNotification.Name("DeliveryUpdate"),
            object: nil
        )
    }

    @objc private func updateStatusButtonTapped() {
        print("🟣 [NotiWithDeliveryViewController] updateStatusButtonTapped 호출됨")
        guard let trackingNumber = trackingNumberTextField.text, !trackingNumber.isEmpty else {
            print("🟣 [NotiWithDeliveryViewController] 운송장 번호가 입력되지 않음")
            statusLabel.text = "운송장 번호를 입력해주세요"
            return
        }

        // 랜덤하게 상태 업데이트
        let statuses: [DeliveryInfo.DeliveryStatus] = [.pickedUp, .inTransit, .delivered]
        let randomStatus = statuses.randomElement()!

        let deliveryInfo = DeliveryInfo(
            trackingNumber: trackingNumber,
            sender: "홍길동",
            receiver: "김철수",
            status: randomStatus,
            timestamp: Date()
        )

        print(
            "🟣 [NotiWithDeliveryViewController] 배송 상태 업데이트 전송 - 운송장번호: \(trackingNumber), 상태: \(randomStatus.rawValue)"
        )
        NotificationCenter.default.post(
            name: NSNotification.Name("DeliveryUpdate"),
            object: deliveryInfo,
            userInfo: nil
        )
    }

    @objc private func handleDeliveryUpdate(_ notification: Notification) {
        print("🟣 [NotiWithDeliveryViewController] handleDeliveryUpdate 호출됨")
        if let deliveryInfo = notification.object as? DeliveryInfo {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .short

            print(
                "🟣 [NotiWithDeliveryViewController] 배송 상태 업데이트 수신 - 운송장번호: \(deliveryInfo.trackingNumber), 상태: \(deliveryInfo.status.rawValue)"
            )

            statusLabel.text = """
                운송장 번호: \(deliveryInfo.trackingNumber)
                발신자: \(deliveryInfo.sender)
                수신자: \(deliveryInfo.receiver)
                상태: \(deliveryInfo.status.rawValue)
                시간: \(dateFormatter.string(from: deliveryInfo.timestamp))
                """
        }
    }

    deinit {
        print("🟣 [NotiWithDeliveryViewController] deinit 호출됨")
        NotificationCenter.default.removeObserver(self)
    }
}
