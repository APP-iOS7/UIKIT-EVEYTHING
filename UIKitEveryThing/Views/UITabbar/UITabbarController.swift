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
        view.backgroundColor = .systemBackground
    }
}

extension UITabbarController {
    func setupTabbar() {
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()

        let firstTab = UITabBarItem(
            title: "first",
            image: UIImage(systemName: "star"),
            selectedImage: UIImage(systemName: "star.fill")
        )
        
        let secondTab = UITabBarItem(
            title: "second",
            image: UIImage(systemName: "star"),
            selectedImage: UIImage(systemName: "star.fill")
        )

        let firstNC = UINavigationController(rootViewController: UITabbarFirstViewController())
        let secondNC = UINavigationController(rootViewController: UITabbarSecondViewController())

        firstNC.tabBarItem = firstTab
        secondNC.tabBarItem = secondTab

        self.tabBar.standardAppearance = appearance
        self.tabBar.scrollEdgeAppearance = appearance

        self.viewControllers = [firstNC, secondNC]
    }
}
