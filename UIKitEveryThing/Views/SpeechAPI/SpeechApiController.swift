//
//  SpeechApiController.swift
//  UIKitEveryThing
//
//  Created by 김용해 on 3/25/25.
//

import UIKit
import AVFoundation

class SpeechApiController: UIViewController {
    //MARK: 변수
    // 텍스트 뷰
    let textview: UITextView = {
        let field = UITextView()
        field.text = "TTA를 위한 입력 값"
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = .systemGray5
        return field
    }()
    
    // 버튼
    let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = UIButton.Configuration.filled()
        button.configuration?.title = "TTA 생성"
        button.configuration?.baseForegroundColor = .white
        return button
    }()
    
    // 음성 합성기
    lazy var speechSynthesizer = AVSpeechSynthesizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpInit()
        setUpTextField()
        setUpButton()
        setUpUIBar()
        button.addAction(UIAction{ [weak self] _ in
            self?.audioPlayer()
        }, for: .touchUpInside)
    }
    
    // MARK:  전체 셋업
    private func setUpInit() {
        self.view.backgroundColor = .white
        navigationItem.title = "TTA Test"
    }
    
    // MARK: 텍스트 필드 설정
    private func setUpTextField() {
        self.view.addSubview(textview)
        
        NSLayoutConstraint.activate([
            textview.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            textview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            textview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            textview.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    // MARK: TTA버튼 함수
    private func setUpButton() {
        self.view.addSubview(button)

        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: textview.bottomAnchor, constant: 20),
            button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            button.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    // MARK: 키보드에 버튼 추가
    private func setUpUIBar() {
        let keyButton: UIToolbar = UIToolbar()
        keyButton.sizeToFit()
        
        /// Space 공간 제약
        let spaceKeyboard = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        /// **  toolBar에 추가할 완료 버튼
        let completeKeyboard = UIBarButtonItem(
            title: "완료",
            style: .done,
            target: self,
            action: #selector(dismissKeyboard)
        )
        keyButton.items = [spaceKeyboard,completeKeyboard]
        
        /// textview에 연결된 키보드의 toolBar에 적용
        textview.inputAccessoryView = keyButton
    }
}


// MARK: 키보드 내리는 함수의 확장 모음
extension SpeechApiController {
    // MARK: 키보드 self.view의 영역을 클릭 했을 때 호출이 됩니다
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true) // 키보드 닫기
    }
    
    // MARK: selector  함수로 키보드의 완료 버튼을 누르면 실행 될 함수
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}

// MARK: 오디오를 실행하는 함수 확장 모음
private extension SpeechApiController {
    // MARK: audioPlayer 함수
    func audioPlayer() {
        let text: String = textview.text.isEmpty ? "text를 넣어주세요" : textview.text
        
        let speechObj = AVSpeechUtterance(string: text)
        speechObj.voice = AVSpeechSynthesisVoice(language: "ko-KR")
        speechObj.rate = 0.5
        
        speechSynthesizer.speak(speechObj)
    }
}



/// ** 회고 3월 26일
///  AVFoundation을 사용해 봤는데
///  목소리 커스텀 부분에 Siri만 가능하다는 점에서 아쉬움이 있네요..
///  createML로 보이스를 학습하면 어찌어찌 될거 같지만 AVFOUNDATION이 가지고 있는 기능들이 아쉬움이 많습니다 :(
///  커스텀은 하지 않고  이 페이지에서는 Keyboard의 기능에 집중했습니다  :)
///
///  1. touchesBegan이라는 메서드 오버라이딩으로 self.view의 영역을 감지할 수 있고 이를 통해 활성화 된 키보드를 닫을 수 있습니다
///  2. TextView는 return의 개념이 없고 아래로 내려가는 여러줄의 TextField이기 때문에 키보드에 완료 Toolbar 하나를 줘서 이벤트 걸고 키보드를 내려보았습니다.
///
