//
//  AppSceneCoordinator.swift
//  UIKitEveryThing
//
//  Created by 김용해 on 7/12/25.
//

import UIKit

class AppSceneCoordinator: Coordinator {
    let window: UIWindow
    var navigationController: UINavigationController
    
    init(window: UIWindow,navigationController: UINavigationController) {
        self.window = window
        self.navigationController = navigationController
    }
    
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        let mainView = MainTableViewController()
        navigationController.pushViewController(mainView, animated: true)
    }
}
