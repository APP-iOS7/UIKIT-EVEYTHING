//
//  UINavigationViewController.swift
//  UIKitEveryThing
//
//  Created by 최범수 on 2025-03-19.
//

import UIKit

class UINavigationViewController: UIViewController {

    private let navigationBarKeys = [
        "barStyle",
        "tintColor",
        "prefersLargeTitles",
        "titleTextAttributes",
    ]

    private var originalState: [String: Any] = [:]
    private var originalIsTranslucent: Bool?

    override func viewDidLoad() {
        print("1️⃣ viewDidLoad")
        view.backgroundColor = .systemBackground
        super.viewDidLoad()
        saveOriginalNavigationState()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        print("2️⃣ viewWillAppear")
        super.viewWillAppear(animated)
        setupNav()
    }

    override func viewDidAppear(_ animated: Bool) {
        print("3️⃣ viewDidAppear")
        super.viewDidAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        print("4️⃣ viewWillDisappear")
        super.viewWillDisappear(animated)
        restoreOriginalNavigationState()
    }

    override func viewDidDisappear(_ animated: Bool) {
        print("5️⃣ viewDidDisappear")
        super.viewDidDisappear(animated)

    }

    func setupNav() {
        self.title = "Navigation Title"
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black
        ]
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.view.backgroundColor = .white
    }
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "첫 번째 탭"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private func setupUI() {
        view.addSubview(mainLabel)

        NSLayoutConstraint.activate([
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

}

// MARK: - Navigation Bar State Management
extension UINavigationViewController {
    func saveOriginalNavigationState() {
        guard let navigationBar = self.navigationController?.navigationBar else { return }

        // KVC-compliant 속성 저장
        navigationBarKeys.forEach { key in
            originalState[key] = navigationBar.value(forKey: key)
        }

        // KVC-noncompliant 속성 직접 저장
        originalIsTranslucent = navigationBar.isTranslucent
    }

    func restoreOriginalNavigationState() {
        guard let navigationBar = self.navigationController?.navigationBar else { return }

        // KVC-compliant 속성 복원
        originalState.forEach { key, value in
            navigationBar.setValue(value, forKey: key)
        }

        // KVC-noncompliant 속성 직접 복원
        if let isTranslucent = originalIsTranslucent {
            navigationBar.isTranslucent = isTranslucent
        }
    }
}

// In view life-cycle, viewDidLoad calld only once it loads in memory.
// to keep it look like changed, need to put function for navStyle in the viewWillAppear life-cycle.
