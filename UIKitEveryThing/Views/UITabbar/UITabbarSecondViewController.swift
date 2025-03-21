//
//  UITabbarSecondViewController.swift
//  UIKitEveryThing
//
//  Created by 최범수 on 2025-03-19.
//

import UIKit

class UITabbarSecondViewController: UIViewController {
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "두 번째 탭"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private let subLabel: UILabel = {
        let label = UILabel()
        label.text = "UIKit 연습하기"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }()
    
    private var observer: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupUI()
        setupObserver()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupUI() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(mainLabel)
        stackView.addArrangedSubview(subLabel)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    private func setupObserver() {
        NotificationCenter.default.addObserver(forName: TomDataSingleton.dataChangeNotification, object: nil, queue: .main) { [weak self] noti in
            print(noti)
            self?.updateLabel()
        }
    }
    
    func updateLabel() {
        subLabel.text = TomDataSingleton.shared.data
    }
}


