//
//  YonghaeTodoList.swift
//  UIKitEveryThing
//
//  Created by 김용해 on 3/19/25.
//

import UIKit




class YonghaeTodoList: UIViewController{
    // 전역 클로저 즉시 실행 함수
    lazy var textField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Todo를 만들어 봅시다"
        field.layer.cornerRadius = 8
        field.borderStyle = UITextField.BorderStyle.roundedRect
        field.backgroundColor = convertHexColor(red: 240, green: 147, blue: 25)
        field.tintColor = convertHexColor(red: 171, green: 186, blue: 124)
        field.textColor = convertHexColor(red: 61, green: 83, blue: 0)
        return field
    }()
    private var todoData: [String] = []
    private var todoTable: YonghaeTodoTableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setUpTextField()
        setUpTableView()
    }
    // MARK: 전체 셋업
    private func setUp() {
        self.view.backgroundColor = .systemYellow
        navigationItem.title = "YONGHAE-TODO"
        let appearance: UINavigationBarAppearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor : convertHexColor(red: 61, green: 83, blue: 0)]
        appearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    // MARK: TextField,button 구성 요소 및 레이아웃
    private func setUpTextField() {
        let rightButton: UIButton = {
            let button: UIButton = UIButton()
            button.setTitle("추가", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .systemRed
            button.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
            button.layer.cornerRadius = 8
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        // 이벤트
        todoSubmit(rightButton: rightButton)
        
        textField.rightView = rightButton
        textField.rightViewMode = .always
        self.view.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30),
            textField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            textField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
            textField.heightAnchor.constraint(equalToConstant: 50),
            // 버튼
            rightButton.widthAnchor.constraint(equalToConstant: 50),
            rightButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: Todos 영역 UITableViewController
    private func setUpTableView() {
        todoTable = YonghaeTodoTableView(todos: todoData)
        self.addChild(todoTable)
        todoTable.view.translatesAutoresizingMaskIntoConstraints = false
        todoTable.view.layer.cornerRadius = 12
        todoTable.view.backgroundColor = .none
        self.view.addSubview(todoTable.view)
        
        NSLayoutConstraint.activate([
            todoTable.view.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            todoTable.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            todoTable.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
            todoTable.view.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    // MARK: todo를 만드는 버튼 Action!!
    private func todoSubmit(rightButton: UIButton) {
        rightButton.addAction(UIAction {_ in
            print("todo : \(self.textField.text ?? "")")
            self.todoData.append(self.textField.text ?? "값이 없어유")
            self.textField.text = ""
            self.todoTable.updateTodos(newTodos: self.todoData)
        }, for: .touchUpInside)
    }
}


// 여기서만 쓰는 확장
private extension YonghaeTodoList {
    // ** 색상 바꿔주는 함수
    func convertHexColor(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        UIColor(red: red/255, green: green / 255, blue: blue / 255, alpha: 1.0)
    }
}


#Preview {
    UINavigationController(rootViewController: YonghaeTodoList())
}


/// ** MARK: 3월 18일 회고
/// 이번에 투두리스트를 Create만 만들어보면서 느낀점은 데이터를 참조하는 방식에 대한 고민과
///  Todos를 가져오기위해 UITableViewController인 이녀석을 컴포넌트처럼 가져오는 방법에 대해 배울수 있는 좋은 기회였다!
///
///.   stackView와 TableView 둘중에 뭘로 todos를 만들까 고민했지만 말도 안되는 고민이었던게...
///.   애초에 stackView는 오로지 정적 View를 위한 class 였고 TableView가 필수였습니다 :(
///.   스택뷰로 여러가지 해봤지만  alignment, spacing , distribution 이 3가지가 핵심이었고 결과적으로 하나의     todo가 있을때 그 UILabel뷰가 전체를 차지하게 됩니다 (2시간의 뺑뱅이 의 결론 ㅋ)
///
///  처음엔 그냥 addSubview하면 되는거 아냐? 라고 생각했지만 안에 넣을 수 있는 타입은 controller가 아닌 UIView이다..
///
///  그렇기에 view관련 코드를 TodoList에서 쓰기 위해 강한 참조를 하여 setUpTableView가 실행 될때 가져오기로 하였다 가져오고 난 후 현재 UIViewController인 TodoList에 addChild라는 함수에 등록을 해줘야 한다!!
///
///  UIView를 view에 저장하기 위해 addSubView를 하는것처럼 controller를 가져오기 위해서는 addChild가 필요한걸 깨달았습니다 :)
///
///  가져온 controller를 view관련 설정 해주기 위해서는 내부의 view 프로퍼티를 이용해주면 됩니다
///
///  1. 문제점 data 관리
///  현재는 data를 관리하기보단 TableViewController에 todos 전체를 todo가 들어갈 때마다 업데이트를 하고 있다...
///  굉장히 문제가 많지만 솔직히 아직 delegate 패턴이나 컴바인이 헷갈리기 때문에 차근차근 공부합시다...
