//
//  LinkViewController.swift
//  UIKitEveryThing
//
//  Created by 최범수 on 2025-03-18.
//

import UIKit

// Declare Components
class LinkViewController: UIViewController {

    private lazy var linkButton: UIButton = buildLinkButton()
    private lazy var alertButton: UIButton = buildAlertButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// Define Conponents
extension LinkViewController {
    func buildLinkButton() -> UIButton {
        
        // 앱에서 버튼의 스타일을 일관적으로 유지하고 싶을 때 enum에 static으로 하면 좋을 듯.
        var config = UIButton.Configuration.plain()
        config.title = "Apple" // attributedTitle을 적용하면 이전것들은 사라짐.
        config.cornerStyle = .capsule
        config.background.backgroundColor = .black
        config.attributedTitle = .init("애플", attributes: AttributeContainer([.underlineStyle: NSUnderlineStyle.single.rawValue, .font: UIFont.systemFont(ofSize: 24)])) // 기본 적용 중, 타이틀의 글자의 관련된 것들만.
        let button = UIButton(configuration: config, primaryAction: UIAction { [weak self] _ in
            self?.openLink()
        })
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    func buildAlertButton() -> UIButton {
        var config = UIButton.Configuration.borderedProminent()
//        config.title = "Show Alert"
        config.attributedTitle = .init("Show Alert", attributes: .init([.font: UIFont.systemFont(ofSize: 24)]))
        
        let button = UIButton(configuration: config, primaryAction: UIAction { [weak self] _ in
            self?.showActionSheet()
        })
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}

// Lay Out UI
extension LinkViewController {
    func setupUI() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(linkButton)
        self.view.addSubview(alertButton)
        
        NSLayoutConstraint.activate([
            linkButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            linkButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            
            alertButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            alertButton.topAnchor.constraint(equalTo: linkButton.bottomAnchor, constant: 24)
        ])
    }
}

// Define Methods
extension LinkViewController {
    func openLink() {
        guard let url = URL(string: "https://www.apple.com"), UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url) { success in
            if success {
                print("Open Complete")
            } else {
                print("Open Fail")
            }
        }
    }
    
    func showActionSheet() {
        let alert = UIAlertController(title: "Alert", message: "message goes here", preferredStyle: .actionSheet)
        let confirm = UIAlertAction(title: "confirm", style: .default) { [weak self] _ in
            self?.showAlert(message: "confirm")
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        let sthElse = UIAlertAction(title: "secon option", style: .destructive) { [weak self] action in
            print(action)
            self?.showAlert(message: "ummm")
        }
        alert.addAction(confirm)
        alert.addAction(sthElse)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okay = UIAlertAction(title: "OK", style: .default) { action in
            // You can put any function to execute
            print(action) // <UIAlertAction: 0x600003018120 Title = "OK" Descriptive = "(null)" Image = 0x0>
            // It has metaData. Name of action, title, and discription and.... image?
            // which means i can put an image for that?
            // and let me figure out how to set discriprion.
            
        }
        
        // wanna put icon for that. let me do that
        okay.setValue(UIImage(systemName: "star"), forKey: "image") // wow it works
        // Then, im gonna put discription message
        // it goes here.
//        okay.setValue("disc", forKey: "descriptiveText") // It works, but changed design....?
        
        let no = UIAlertAction(title: "NO", style: .destructive) { UIAlertAction in
            print("I said No")
        }
        
        alert.addAction(okay)
        alert.addAction(no)
        
        present(alert, animated: true) {
            print("alert present successfully, it is send by completion handler of alert present function")
        }
    }
}


// 강사님 코드
private class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    setupUI()
  }

  func setupUI() {
    // 디폴트 버튼 설정
    var config = UIButton.Configuration.plain()

    // 밑줄 스타일
    let attributedTitle = AttributedString("메뉴 열기")
    var container = AttributeContainer()
    container.underlineStyle = [.single]
    container.underlineColor = .systemBlue
    container.font = .systemFont(ofSize: 50)

    let underlinedTitle = attributedTitle.settingAttributes(container)
    config.attributedTitle = underlinedTitle

    // 버튼 생성
    let button = UIButton(configuration: config)
    button.addAction(UIAction { [weak self] _ in
      print("버튼 클릭")
      self?.showMenu()
    }, for: .touchUpInside)

    button.translatesAutoresizingMaskIntoConstraints = false

    view.addSubview(button)

    // 제약조건 설정
    NSLayoutConstraint.activate([
      button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }

  func showMenu() {
    let alert = UIAlertController(title: "메뉴", message: "메뉴를 선택하세요", preferredStyle: .actionSheet)

    // 클로저를 직접 사용하는 방식으로 변경
    alert.addAction(UIAlertAction(title: "Open", style: .default) { [weak self] _ in
      self?.showMessage("Open 선택됨")
    })

    alert.addAction(UIAlertAction(title: "Find", style: .default) { [weak self] _ in
      self?.showMessage("Find 선택됨")
    })

    alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
      self?.showMessage("Delete 선택됨")
    })

    // 취소 액션 추가 ( 외부 탭 닫힘도 같이 동작함 )
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

    // 아이패드에서 팝오버 형태로 메뉴를 표시하기 위한 설정입니다.
    if let popoverController = alert.popoverPresentationController {
      popoverController.sourceView = view
      popoverController.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
      popoverController.permittedArrowDirections = [.down]
    }

    // 액션 시트를 표시합니다.
    present(alert, animated: true)
  }

  private func showMessage(_ message: String) {
    // UIAlertController를 사용하여 알림을 생성합니다.
    let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
    // "OK" 액션을 추가합니다.
    alert.addAction(UIAlertAction(title: "확인", style: .default))
    // 알림을 표시합니다.
    present(alert, animated: true)
  }


  private func openLink() {
    if let url = URL(string: "https://www.apple.com"),
       UIApplication.shared.canOpenURL(url) {
      UIApplication.shared.open(url) { success in
        if success {
          print("웹사이트 열기 성공")
        } else {
          print("웹사이트 열기 실패")
        }
      }
    }
  }
}

#Preview {
  ViewController()
}
