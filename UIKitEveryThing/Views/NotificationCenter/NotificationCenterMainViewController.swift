import UIKit

class NotificationCenterMainViewController: UIViewController {

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let basicButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("기본 NotificationCenter 예제", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()

    private let objectButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Object를 사용한 NotificationCenter 예제", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()

    private let structButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Struct를 사용한 NotificationCenter 예제", for: .normal)
        button.backgroundColor = .systemOrange
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()

    private let deliveryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("택배 시스템 NotificationCenter 예제", for: .normal)
        button.backgroundColor = .systemPurple
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupButtons()
    }

    private func setupUI() {
        view.backgroundColor = .white
        title = "NotificationCenter 예제"

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalToConstant: 300),
        ])

        [basicButton, objectButton, structButton, deliveryButton].forEach {
            stackView.addArrangedSubview($0)
            $0.heightAnchor.constraint(equalToConstant: 60).isActive = true
        }
    }

    private func setupButtons() {
        basicButton.addTarget(self, action: #selector(basicButtonTapped), for: .touchUpInside)
        objectButton.addTarget(self, action: #selector(objectButtonTapped), for: .touchUpInside)
        structButton.addTarget(self, action: #selector(structButtonTapped), for: .touchUpInside)
        deliveryButton.addTarget(self, action: #selector(deliveryButtonTapped), for: .touchUpInside)
    }

    @objc private func basicButtonTapped() {
        let vc = NotiViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc private func objectButtonTapped() {
        let vc = NotiWithObjectViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc private func structButtonTapped() {
        let vc = NotiWithStructViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc private func deliveryButtonTapped() {
        let vc = NotiWithDeliveryViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
