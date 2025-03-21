//
//  YonghaeTodoDetailVC.swift
//  UIKitEveryThing
//
//  Created by 김용해 on 3/21/25.
//

import UIKit

class YonghaeTodoDetailVC: UIViewController {
    var currentTodo: Todo // Todo 받아오기
    weak var delegate: UpdateTextFieldDelegate? // delegate 패턴
    init(currentTodo: Todo) {
        self.currentTodo = currentTodo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    lazy var updateField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.delegate = self
        field.text = currentTodo.title
        field.backgroundColor = .systemBackground
        field.layer.cornerRadius = 8
        return field
    }()
    lazy var updateButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("수정하기", for: .normal)
        button.layer.cornerRadius = 8
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        updateButtonConfigure()
    }
    
    // MARK: 초기 설정
    private func configure() {
        self.view.backgroundColor = UIColor.convertHexColor(red: 217, green: 131, blue: 36)
        navigationItem.title = "할건.. 해야지"
    }
    
    // MARK: 업데이트 버튼 동작 이벤트
    private func updateButtonConfigure() {
        updateButton.addAction(UIAction {_ in
            // Text 유효성 검사
            guard let updateText = self.updateField.text, !updateText.isEmpty else {
                return
            }
            self.currentTodo.title = updateText // Text 바꿔치기
            self.delegate?.updateTodos(todo: self.currentTodo) // text를 넘겨줌으로써 전 View에서 viewContext를 처리하기 위함.(delegate 위임)
            self.dismiss(animated: true)
        }, for: .touchUpInside)
        
        self.view.addSubview(updateField)
        self.view.addSubview(updateButton)
        
        NSLayoutConstraint.activate([
            updateField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            updateField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            updateField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
            updateField.heightAnchor.constraint(equalToConstant: 70),
            
            //button
            updateButton.topAnchor.constraint(equalTo: updateField.bottomAnchor, constant: 30),
            updateButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            updateButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
            updateButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}


extension YonghaeTodoDetailVC: UITextFieldDelegate {
    // 키보드 열기
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        true
    }
    
    // return시 키보드 닫기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        updateField.resignFirstResponder()
        return true
    }
}


#Preview {
    YonghaeTodoDetailVC(currentTodo: Todo(title: "test"))
}
