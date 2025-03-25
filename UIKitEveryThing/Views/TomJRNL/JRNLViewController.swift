//
//  JRNLViewController.swift
//  UIKitEveryThing
//
//  Created by 최범수 on 2025-03-25.
//

import UIKit

class TomJRNLTabbarController: UITabBarController {
    
    override func viewDidLoad() {
        setupTabs()
    }

    private func setupTabs() {
        let journalTab = UITabBarItem(title: "Journal", image: UIImage(systemName: "person"), tag: 0)
        let mapTab = UITabBarItem(title: "Map", image: UIImage(systemName: "map"), tag: 1)
        let journalNC = UINavigationController(rootViewController: TomJournalViewController())
        let mapNC = UINavigationController(rootViewController: TomMapViewController())
        journalNC.tabBarItem = journalTab
        mapNC.tabBarItem = mapTab
        self.viewControllers = [journalNC, mapNC]
    }
}
