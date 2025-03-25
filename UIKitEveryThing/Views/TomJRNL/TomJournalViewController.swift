//
//  TomJRNLViewController.swift
//  UIKitEveryThing
//
//  Created by 최범수 on 2025-03-25.
//

import UIKit

class TomJournalViewController: UIViewController {

    private lazy var NavPlusButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(navPlusButtonDidTap))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

private extension TomJournalViewController {
    func setupUI() {
        self.view.backgroundColor = .systemBackground
        setupNav()
    }
    
    func setupNav() {
        self.navigationItem.title = "Journal"
        self.navigationItem.rightBarButtonItem = NavPlusButton
    }
}

private extension TomJournalViewController {
    @objc func navPlusButtonDidTap() {
        // TODO: Make tap action
    }
}
