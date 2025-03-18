//
//  UIGestureViewController.swift
//  UIKitEveryThing
//
//  Created by 최범수 on 2025-03-18.
//

import UIKit

// Declare Components
class UIGestureViewController: UIViewController {

    private lazy var rectangular: UIView = buildRectangular()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupGesture()
    }
}

// Define Components
extension UIGestureViewController {
    func buildRectangular() -> UIView {
        let rect = UIView()
        rect.translatesAutoresizingMaskIntoConstraints = false
        rect.layer.borderWidth = 2
        rect.layer.borderColor = UIColor.black.cgColor
        rect.backgroundColor = .lightGray
        return rect
    }
}

// Lay out UI
extension UIGestureViewController {
    func setupUI() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(rectangular)
        
        NSLayoutConstraint.activate([
            rectangular.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            rectangular.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            rectangular.widthAnchor.constraint(equalToConstant: 80),
            rectangular.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
}

// Set up Gesture
extension UIGestureViewController {
    func setupGesture() {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(handleTapGesture))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        rectangular.addGestureRecognizer(tapGesture) // perfcet~
    }
    
    @objc func handleTapGesture() {
        print("Tapped")
    }
}


private class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    setupUI()
    setupGesture()
  }

  func setupUI() {
    let rectangle = UIView()
    rectangle.backgroundColor = .yellow
    rectangle.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(rectangle)

    NSLayoutConstraint.activate([
      rectangle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
      rectangle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 100),
      rectangle.widthAnchor.constraint(equalToConstant: 175),
      rectangle.heightAnchor.constraint(equalToConstant: 125)
    ])
  }

  func setupGesture() {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
    tapGesture.numberOfTapsRequired = 2 // 더블 탭
    tapGesture.numberOfTouchesRequired = 1 // 한 손가락
    view.addGestureRecognizer(tapGesture)
  }

  @objc func handleTapGesture() {
    print("더블 탭 제스처 인식")
  }

}

