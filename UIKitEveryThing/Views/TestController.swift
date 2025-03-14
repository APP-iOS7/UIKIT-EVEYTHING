//
//  TestController.swift
//  UIKitEveryThing
//
//  Created by 김용해 on 3/13/25.
//

import UIKit

// ** MARK: 테스트용 다음 라우트 Controller
class TestController: UIViewController {
    let receivedTitle: String
    
    init(receivedTitle: String) {
        self.receivedTitle = receivedTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    // ** MARK: 초기 TestController 설정
    func setUpUI() {
        // 제목 설정
        self.view.backgroundColor = .white
        navigationItem.title = receivedTitle
    }
}
