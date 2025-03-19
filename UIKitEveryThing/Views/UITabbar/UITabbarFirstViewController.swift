//
//  UITabbarFirstViewController.swift
//  UIKitEveryThing
//
//  Created by 최범수 on 2025-03-19.
//

import UIKit

class UITabbarFirstViewController: UIViewController {

    private let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "첫 번째 탭"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        setupUI()
    }

    private func setupUI() {
        view.addSubview(mainLabel)

        NSLayoutConstraint.activate([
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

}
