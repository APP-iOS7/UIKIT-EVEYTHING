//
//  ViewController.swift
//  UIKitEveryThing
//
//  Created by 김용해 on 3/13/25.
//

import UIKit


// ** Navigation Controller로 MainTableViewController를 담고 있다
class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpUI()
    }
    
    func setUpUI() {
        self.view.backgroundColor = .white
    }
}

