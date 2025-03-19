//
//  UITabbarFirstViewController.swift
//  UIKitEveryThing
//
//  Created by 최범수 on 2025-03-19.
//

import UIKit

class UITabbarFirstViewController: UIViewController {

     let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "첫 번째 탭"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let button: UIButton = {
        let button = UIButton(configuration: .filled())
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        button.setTitle("받아라 친구야", for: .normal)
        return button
    }()

    func sendMessage() {
        TomDataSingleton.shared.updateData(newData: "엤다 가져가라")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        setupUI()
        button.addAction(UIAction(handler: { [weak self] action in
            print("action: \(action)")
            self?.sendMessage()
        }), for: .touchUpInside)
    }

    func setupUI() {
        view.addSubview(mainLabel)
        view.addSubview(button)

        NSLayoutConstraint.activate([
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

}
