//
//  JRNLViewController.swift
//  UIKitEveryThing
//
//  Created by 최범수 on 2025-03-25.
//

import UIKit

class TomJRNLTabbarController: UITabBarController {
    
    private let firstTab: UITab = {
        let tab = UITab(title: "Journal", image: UIImage(systemName: "person.fill"), identifier: "Title") { _ in
            UINavigationController(rootViewController: TomJournalViewController())
        }
        
        return tab
    }()
    
    private let secondTab: UITab = {
        let tab = UITab(title: "Map", image: UIImage(systemName: "map"), identifier: "Title") { _ in
            UINavigationController(rootViewController: TomMapViewController())
        }
        
        return tab
    }()
    
    override func viewDidLoad() {
        self.tabs = [firstTab, secondTab]
    }

}
