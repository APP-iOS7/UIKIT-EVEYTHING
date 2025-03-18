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
