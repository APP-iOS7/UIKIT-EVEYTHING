//
//  UINavigationViewController.swift
//  UIKitEveryThing
//
//  Created by 최범수 on 2025-03-19.
//

import UIKit

class UINavigationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        self.navigationController?.navigationBar.tintColor = .blue

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.tintColor = .blue

    }
    
    func setupNav() {
        self.title = "Navigation Title"
        
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.prefersLargeTitles = true
//        self.navigationController?.navigationBar.isHidden = true

        self.view.backgroundColor = .white
    }
}
