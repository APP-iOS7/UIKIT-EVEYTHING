import UIKit

// 메시지 전송자 구조체
struct StructMessageSender: Equatable {
    let name: String
    let id: Int

    static func == (lhs: StructMessageSender, rhs: StructMessageSender) -> Bool {
        return lhs.id == rhs.id
    }

    init(name: String, id: Int) {
        self.name = name
        self.id = id
        print("🟡 [StructMessageSender] 초기화됨 - 이름: \(name), ID: \(id)")
    }
}

class NotiWithStructViewController: UIViewController {

    private let label: UILabel = {
        let label = UILabel()
        label.text = "struct는 안됨. class로 하자."
        label.frame = CGRect(x: 100, y: 100, width: 300, height: 100)
        label.textAlignment = .center
        return label
    }()

    private let sender1 = StructMessageSender(name: "홍길동", id: 1)
    private let sender2 = StructMessageSender(name: "김철수", id: 2)

    private let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "메시지가 여기에 표시됩니다"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let sender1Button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("홍길동 메시지 전송", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let sender2Button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("김철수 메시지 전송", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("🟡 [NotiWithStructViewController] viewDidLoad 호출됨")
        setupUI()
        setupNotificationObserver()
    }

    private func setupUI() {
        print("🟡 [NotiWithStructViewController] setupUI 호출됨")
        view.backgroundColor = .white
        title = "Notification Center Struct 예제"

        view.addSubview(messageLabel)
        view.addSubview(sender1Button)
        view.addSubview(sender2Button)
        view.addSubview(label)

        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            sender1Button.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20),
            sender1Button.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            sender2Button.topAnchor.constraint(equalTo: sender1Button.bottomAnchor, constant: 10),
            sender2Button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])

        sender1Button.addTarget(self, action: #selector(sender1ButtonTapped), for: .touchUpInside)
        sender2Button.addTarget(self, action: #selector(sender2ButtonTapped), for: .touchUpInside)
    }

    private func setupNotificationObserver() {
        print("🟡 [NotiWithStructViewController] setupNotificationObserver 호출됨")
        // 홍길동의 메시지만 관찰
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleMessage(_:)),
            name: NSNotification.Name("NewMessage"),
            object: sender1
        )

        // 김철수의 메시지만 관찰
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleMessage(_:)),
            name: NSNotification.Name("NewMessage"),
            object: sender2
        )
    }

    @objc private func sender1ButtonTapped() {
        print("🟡 [NotiWithStructViewController] sender1ButtonTapped 호출됨")
        NotificationCenter.default.post(
            name: NSNotification.Name("NewMessage"),
            object: sender1,
            userInfo: ["message": "\(sender1.name)의 메시지입니다! \(Date())"]
        )
    }

    @objc private func sender2ButtonTapped() {
        print("🟡 [NotiWithStructViewController] sender2ButtonTapped 호출됨")
        NotificationCenter.default.post(
            name: NSNotification.Name("NewMessage"),
            object: sender2,
            userInfo: ["message": "\(sender2.name)의 메시지입니다! \(Date())"]
        )
    }

    @objc private func handleMessage(_ notification: Notification) {
        print("🟡 [NotiWithStructViewController] handleMessage 호출됨\(notification)")
        if let sender = notification.object as? StructMessageSender,
            let message = notification.userInfo?["message"] as? String
        {
            print(
                "🟡 [NotiWithStructViewController] 받은 메시지 - 발신자: \(sender.name)(ID: \(sender.id)), 내용: \(message)"
            )
            messageLabel.text = "\(sender.name)(ID: \(sender.id))으로부터: \(message)"
        }
    }

    deinit {
        print("🟡 [NotiWithStructViewController] deinit 호출됨")
        NotificationCenter.default.removeObserver(self)
    }
}
