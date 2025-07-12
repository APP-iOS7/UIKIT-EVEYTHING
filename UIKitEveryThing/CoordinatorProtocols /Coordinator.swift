//
//  Coordinator.swift
//  UIKitEveryThing
//
//  Created by 김용해 on 7/12/25.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get }
    func start()
}
