//
//  UITabbarViewController.swift
//  UIKitEveryThing
//
//  Created by 최범수 on 2025-03-19.
//

import UIKit

class UITabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabbar()
    }
}

private extension UITabbarController {
    func setupTabbar() {
        let firstTabItem = UITabBarItem(
            title: "First", image: UIImage(systemName: "star"), tag: 2000)
        let secondTabItem = UITabBarItem(tabBarSystemItem: .featured, tag: 2001)
        let firstNC = UINavigationController(rootViewController: UITabbarFirstViewController())
        let secondNC = UINavigationController(rootViewController: UITabbarSecondViewController())
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        firstNC.tabBarItem = firstTabItem
        secondNC.tabBarItem = secondTabItem
        self.viewControllers = [firstNC, secondNC]
        self.tabBar.standardAppearance = appearance
    }
}
