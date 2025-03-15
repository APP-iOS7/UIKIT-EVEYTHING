//
//  TestController.swift
//  UIKitEveryThing
//
//  Created by 김용해 on 3/13/25.
//

import UIKit

// ** MARK: 테스트용 다음 라우트 Controller
final class YonghaeUIView: UIViewController {
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
        setUpUIView_first()
    }
    
    // ** MARK: 초기 TestController 설정
    private func setUpUI() {
        // 제목 설정
        self.view.backgroundColor = .white
        navigationItem.title = receivedTitle
    }
    
    private func setUpUIView_first() {
        let container: UIView = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .systemBlue
        container.layer.cornerRadius = 8
        container.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(test)))
        self.view.addSubview(container)
        NSLayoutConstraint.activate([
            container.widthAnchor.constraint(equalToConstant: 50),
            container.heightAnchor.constraint(equalToConstant: 50),
            container.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            container.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    
    @objc private func test() {
        print("배경을 누르면 이벤트가 일어나나??")
    }
}



///** MARK: 회고
///
/// 1. 제목을 전달 받으면 생성자 함수에서 receivedTitle 에 값을 넣어주고 부모의 기본 생성자를 넣어주는 이유는 내부 UIViewController 내부 초기화 과정이 필요하기 때문입니다

/// YonghaeUIView 컨트롤러가 다른데서 또 상속이 가능할 수도 있으니까? 만약 final class로 선언하면 상속의 가능성이 사라진다는 의미를 가짐
///
/// 2. required init? coder 은 스토리 보드를 사용하지 않지만 기본적으로 넣어줘야 하는 생성자 코드이며 fatalError로 막아주면 되는것

