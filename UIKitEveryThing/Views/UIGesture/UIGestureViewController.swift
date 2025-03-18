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
        guard let rect = view.subviews.first else { return }
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(handleTapGesture))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        
        let doubleTapGestures = UITapGestureRecognizer()
        doubleTapGestures.numberOfTapsRequired = 2
        doubleTapGestures.numberOfTouchesRequired = 1
        doubleTapGestures.addTarget(self, action: #selector(handleDoubleTapGesture))
        rect.addGestureRecognizer(tapGesture)
        rect.addGestureRecognizer(doubleTapGestures)
    }
    
    @objc func handleTapGesture() {
        print("Tapped")
        dump(self.view.subviews)
    }
    
    @objc func handleDoubleTapGesture() {
        print("Double Tapped")
    }
}


private class ViewController: UIViewController {
    let RECTANGLE_VIEW_TAG = 1000

    override func viewDidLoad() {
      super.viewDidLoad()

      setupUI()
      setupGesture()
    }

    func setupUI() {
      let rectangle = UIView()
      rectangle.backgroundColor = .yellow
      rectangle.translatesAutoresizingMaskIntoConstraints = false
      rectangle.tag = RECTANGLE_VIEW_TAG
      view.addSubview(rectangle)

      NSLayoutConstraint.activate([
        rectangle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
        rectangle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 100),
        rectangle.widthAnchor.constraint(equalToConstant: 175),
        rectangle.heightAnchor.constraint(equalToConstant: 125)
      ])
    }

    func setupGesture() {
      print("subviews count: \(view.subviews.count)")
      guard let rectangle = view.subviews.first(where: { $0.tag == RECTANGLE_VIEW_TAG }) else {
        return
      }
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
      tapGesture.numberOfTapsRequired = 2 // 더블 탭
      tapGesture.numberOfTouchesRequired = 1 // 한 손가락
      rectangle.addGestureRecognizer(tapGesture)
    }

    @objc func handleTapGesture() {
      print("더블 탭 제스처 인식")
    }

  }

  #Preview {
    ViewController()
  }

