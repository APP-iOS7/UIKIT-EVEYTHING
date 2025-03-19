//
//  TestController.swift
//  UIKitEveryThing
//
//  Created by 김용해 on 3/13/25.
//

import UIKit

// ** MARK: 테스트용 다음 라우트 Controller
final class YonghaeUIView: UIViewController {
    private let receivedTitle: String // 외부에서 받아오는 값
    private var isCircle: Bool = false // 내부의 UIView가 원형인지 네모인지 확인 하는 값
    let appearence = UINavigationBarAppearance()// navigationBar 인스턴스
    private lazy var globalUIView: UIView = { // 즉시 실행 클로저 함수로 UIView를 YonghaeUIView에서 사용 가능한 형태
        let uiView = UIView()
        uiView.translatesAutoresizingMaskIntoConstraints = false
        uiView.backgroundColor = .systemBlue
        uiView.layer.cornerRadius = 8
        return uiView
    }() // 전역 UIView
    private lazy var globalButton: UIButton = {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 12
        button.setTitle("None Configuration", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        
        return button
    }() // 전역 UIButton
    init(receivedTitle: String) {
        self.receivedTitle = receivedTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI() // 초기 세팅
        setUpUIView() // uiView 세팅
    }
    
    // MARK: 다시 들어갈 때 isCircle인 경우 글자색 사라짐 이슈
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isCircle {
            appearence.titleTextAttributes = [.foregroundColor : UIColor.white]
            navigationController?.navigationBar.standardAppearance = appearence
            navigationController?.navigationBar.scrollEdgeAppearance = appearence
        }
    }
    
    // MARK: 생명주기 뒤로갈때 Navigation 색상 되돌리기 위함.
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isCircle {
            appearence.titleTextAttributes = [.foregroundColor : UIColor.black]
            navigationController?.navigationBar.standardAppearance = appearence
            navigationController?.navigationBar.scrollEdgeAppearance = appearence
        }
    }
    
    // ** MARK: 초기 YonghaeUIView 설정
    private func setUpUI() {
        // 제목 설정
        self.view.backgroundColor = .white
        navigationItem.title = receivedTitle
        appearence.configureWithTransparentBackground() // 투명 배경색!?!?!? 나이스
    }
    
    // ** MARK: globalUIView 세팅
    private func setUpUIView() {
        globalUIView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapHandler)))
        self.view.addSubview(globalUIView)
        self.view.addSubview(globalButton)
        NSLayoutConstraint.activate([
            globalUIView.widthAnchor.constraint(equalToConstant: 50),
            globalUIView.heightAnchor.constraint(equalToConstant: 50),
            globalUIView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            globalUIView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            
            globalButton.widthAnchor.constraint(equalToConstant: 200),
            globalButton.heightAnchor.constraint(equalToConstant: 50),
            globalButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            globalButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 100)
        ])
    }
    
    // ** MARK: TapGesture 핸들러 함수
    @objc private func tapHandler() {
        isCircle.toggle()
        print("UIView를 누르면 이벤트 Tap이 잘 일어납니다. isCircle : \(isCircle)")

        // -------- 기능 부분 ---------
        
        let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut){ [weak self] in
            self?.updateUIView()
            self?.updateButton() // 적용 안됨.
        }
        animator.startAnimation()
    }
    
    // ** MARK: Tap 이벤트 발생 시 업데이트 함수
    private func updateUIView() {
        if isCircle {
            globalUIView.layer.cornerRadius = 25
            globalUIView.backgroundColor = .systemRed
            platformAdaptorNavigationStyle(foregroundColor: .white)
            self.view.backgroundColor = .black
        }else {
            globalUIView.layer.cornerRadius = 8
            globalUIView.backgroundColor = .systemBlue
            platformAdaptorNavigationStyle(foregroundColor: .black)
            self.view.backgroundColor = .white
        }
    }
    // ** MARK: Button 함수
    private func updateButton() {
        if isCircle {
            globalButton.backgroundColor = .systemRed
        }else {
            globalButton.backgroundColor = .systemBlue
        }
    }
    
    // ** MARK: IOS 15 이상의 경우와 아닌 경우를 분리하는 함수
    private func platformAdaptorNavigationStyle(foregroundColor: UIColor) {
        appearence.titleTextAttributes = [.foregroundColor : foregroundColor]
        navigationController?.navigationBar.standardAppearance = appearence
        navigationController?.navigationBar.scrollEdgeAppearance = appearence
    }
}

#Preview {
    YonghaeUIView(receivedTitle: "test")
}


///** MARK: 회고( 3월 16일 )
///
/// 1. 제목을 전달 받으면 생성자 함수에서 receivedTitle 에 값을 넣어주고 부모의 기본 생성자를 넣어주는 이유는 내부 UIViewController 내부 초기화 과정이 필요하기 때문입니다

/// YonghaeUIView 컨트롤러가 다른데서 또 상속이 가능할 수도 있으니까? 만약 final class로 선언하면 상속의 가능성이 사라진다는 의미를 가짐
///
/// 2. required init? coder 은 스토리 보드를 사용하지 않지만 기본적으로 넣어줘야 하는 생성자 코드이며 fatalError로 막아주면 되는것


/// ** MARK: 회고 (3월 17일)
///
/// 이번 목표는 저번에 클릭 탭 이벤트 가 되는걸 확인했으니 다크모드 비슷하게 배경과 UIView의 색상을 toggle로 바꿔보는 기능을 만들어 보았습니다.
///
/// 문제점은 2가지
/// 1. navigationItem.title의 색상 style의 변화 배경색이 변하면서 제목 부분의 색상과 똑같아졌습니다.
/// 2. navigationItem의 title 부분과 같은 style을 변경하는 코드가 IOS 13 / IOS 15 코드가 바뀌었습니다.
///
/// 1번 , 2번 을 해결하기 위해 #available 같은 분기처리 코드를 적용하였고  NavigationItem 의 배경색과 색상을 바꿔주었습니다.
/// 배경색을 바꾼 이유는 기본 값으로 색상이 회색이 들어가 있어서 바꿨습니다.
///
/// 코드의 가독성을 위해 함수를 분리 하고 순차적으로 배열했습니다 :)
///
/// 기존의 let globalUIView를 바꾼 이유는 YonghaeUIView가 인스턴스 화 될때 바로 메모리에 올라가고 있기 때문에 lazy var를 사용했습니다
/// 어차피 viewDidLoad에서 처음 사용  될것이므로 viewDidLoad가 실행 될때 초기화 되는것이 YonghaeUIView가 인스턴스가 될때 보다 더욱 효율적이라고 판단했습니다.
///
/// 이젠 Animation인데.. 적용방법은 굉장히 쉬웠습니다.  UIView.animate 라는 함수로 적용하면 됩니다.

/// 문제는 NavigationItem 부분은 UIView가 아니라 동시에 animation이 바뀌진 않는 부분입니다..  :(
///
///
/// AI 답변 :
/// 시간차가 발생하는 이유는 애니메이션과 UI 업데이트가 동시에 일어나기 때문입니다. 애니메이션이 실행되는 동안 UI가 서서히 변화하게 되며, UI 요소들의 동기화가
/// 다르게 이루어질 수 있습니다.
///
/// 따라서, 애니메이션이 끝난 후 색상을 변경하거나, 애니메이션과 색상 변경을 동기화할 필요가 있습니다.
///
/// 흠 결국엔 Animation의 시간과 뷰의 렌더링되는 시간이 서로 다르기에 애니메이션이 변하는 동안 NavigationItem 부분은 이미 더 빨리 바뀌고 있는 모습이다. ㅠ
///
/// animate의 completion에 넣으면 반대로 NavigationItem 쪽이 더 느려지는 모습이보입니다. 결국 2개의 애니메이션 시간을 일치 시켜야 하는 작업이 필요해 보입니다 :(
///
/// ** MARK: 회고 (3월 18일)
/// 제가 원하는 animation은 NavigationBar의 배경색 , 버튼 색상 , UIView 색상 이 동시에 시작해서 동시에 마무리 되는 animation을 원하는데 문제는 UIView.animate는 UIView만 제어하고 있었습니다.. ㅠ 다른 방법을 찾아봐야 할거 같습니다
/// UIViewPropertyAnimator 이름에서도 알 수 있듯이 이 녀석도 똑같은 놈입니다..
///
/// Navigation의 background를 투명하게 해서 직접 지정하는 빙식이 아닌 UIView.animate가 실행이 되면 바뀌게 하는게 더 좋은 방식인 거 같습니다 :)
///
/// 이제 Button은 configuration의 baseBackgroundColor는 UIView의 프로퍼티가 아니기 때문에 UIView.animate가 되지 않습니다
/// 다른 방식으로의 접근이 필요합니다
/// ** MARK: 3월 18일 저녘 10시
/// 드디어 비밀을 풀었습니다..
/// baseBackground의 상세 정보를 확인해보니 변하지 않는 색상이라고도 되있고 animation적용이 안되더라구요
///
/// 그래서 setTitle 과 setTintColor를 사용해서  버튼을 만들고 배경색을 backgroundColor로 주면
/// UIView가 가지고 있는 프로퍼티 이므로 Animation 동작을 일으킬 수 있습니다 !!!

