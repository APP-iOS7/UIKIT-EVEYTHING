//
//  JournalModalViewController.swift
//  UIKitEveryThing
//
//  Created by 최범수 on 2025-03-25.
//

import UIKit

class JournalModal: UIViewController {
    
    private lazy var stackView: UIStackView = {
        let vstack = UIStackView()
        vstack.translatesAutoresizingMaskIntoConstraints = false
        vstack.distribution = .fillEqually
        vstack.axis = .vertical
        vstack.alignment = .leading
        vstack.spacing = 8
        
        return vstack
    }()
    
    private lazy var completionSwitch: UISwitch = {
        let sw = UISwitch()
        // TODO: Set Logic
        return sw
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "오늘밤 주인공은 나야 나!"
        
        return textField
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        
        return textView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNav()
    }
}

private extension JournalModal {
    func setupUI() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(stackView)
        
        stackView.addArrangedSubview(completionSwitch)
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(textView)
        stackView.addArrangedSubview(imageView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            
            textView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
    }
    
    func setupNav() {
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonDidTap))
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonDidTap))
        self.navigationItem.title = "New Entry"
        self.navigationItem.leftBarButtonItem = cancelButton
        self.navigationItem.rightBarButtonItem = saveButton
    }
}

private extension JournalModal {
    @objc func cancelButtonDidTap() {
        dismiss(animated: true)
    }
    
    @objc func saveButtonDidTap() {
        
        dismiss(animated: true)
    }
}
