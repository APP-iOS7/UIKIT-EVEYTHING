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

extension UITabbarController {
    fileprivate func setupTabbar() {
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

// 데이터를 구독형태로, 1:N 형태로 주고 받기위해 싱글톤 객체를 생성하고 이 친구가 관리할거임.
class TomDataSingleton {
    static let shared: TomDataSingleton = TomDataSingleton()  // singleton instanse create
    static let dataChangeNotification = Notification.Name("TomDataNoti")

    private init() {}  // make init private

    private(set) var data: String = "" // 데이터의 getter만 제공하여 직접적인 접근을 예방...?

    func updateData(newData: String) {
        data = newData // 새로운 데이터를 싱글톤의 data 변수에 할당.
        NotificationCenter.default.post(name: TomDataSingleton.dataChangeNotification, object: nil) // 나 바꼈다! 알람 듣는놈들아
    }
}

// NotificationCenter는 시스템에서 직접 지원하는 notifier임.
// 조금 더 발전하면 다른 프로세스에서의 알람도 수신 가능하다고 함.
