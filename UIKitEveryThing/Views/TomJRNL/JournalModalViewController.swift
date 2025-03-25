//
//  JournalModalViewController.swift
//  UIKitEveryThing
//
//  Created by 최범수 on 2025-03-25.
//

import UIKit

class JournalModal: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNav()
    }
}

private extension JournalModal {
    func setupUI() {
        self.view.backgroundColor = .systemBackground
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
