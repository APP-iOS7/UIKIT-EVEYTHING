////
////  UIImageViewController.swift
////  UIKitEveryThing
////
////  Created by 최범수 on 2025-03-17.
////
//
//import UIKit
//
//// MARK: - Declare Components
//class UIImageViewController: UIViewController {
//
//    private let circleRadius: CGFloat = 40
//    private let rectangularSize: CGSize = .init(width: 80, height: 80)
//
//    private lazy var scrollView: UIScrollView = buildScrollView()
//    private lazy var stackView: UIStackView = buildStackView(axis: .vertical)
//    private lazy var firstTitleLabel: UILabel = buildLabel(title: "1. 도형 그리기")
//    private lazy var shapeStackView: UIStackView = buildStackView(axis: .horizontal)
//    private lazy var circle: UIView = buildCircle()
//    private lazy var rectangular: UIView = buildRectangular()
//    private lazy var secondTitleLabel: UILabel = buildLabel(title: "2. 이미지 넣기")
//    private lazy var scaleAsoectFitImage: UIImageView = buildImageView(imageName: "car", contentMode: .scaleAspectFit)
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//    }
//}
//
//// MARK: - Define Components
//private extension UIImageViewController {
//
//    func buildScrollView() -> UIScrollView {
//        let scrollView = UIScrollView()
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        scrollView.backgroundColor = .green
//        return scrollView
//    }
//
//    func buildStackView(axis: NSLayoutConstraint.Axis) -> UIStackView {
//        let stackView = UIStackView()
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.axis = axis
//        stackView.spacing = 18
//        stackView.backgroundColor = .gray
//        return stackView
//    }
//
//    func buildLabel(title: String) -> UILabel {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = title
//        label.font = .systemFont(ofSize: 24)
//        return label
//    }
//
//    func buildCircle() -> UIView {
//        let circle = UIView()
//        circle.translatesAutoresizingMaskIntoConstraints = false
//        circle.backgroundColor = UIColor.blue
//        circle.layer.borderColor = UIColor.black.cgColor
//        circle.layer.cornerRadius = circleRadius
//        circle.layer.borderWidth = 2
//        return circle
//    }
//
//    func buildRectangular() -> UIView {
//        let rectangular = UIView()
//        rectangular.translatesAutoresizingMaskIntoConstraints = false
//        rectangular.backgroundColor = UIColor.yellow
//        rectangular.layer.borderWidth = 2
//        rectangular.layer.borderColor = UIColor.black.cgColor
//        return rectangular
//    }
//
//    func buildImageView(imageName: String, contentMode: UIImageView.ContentMode) -> UIImageView {
//        let imageView = UIImageView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.image = UIImage(named: imageName)
//        imageView.contentMode = .scaleAspectFill
//        return imageView
//    }
//}
//
//// MARK: - Lay out UI
//private extension UIImageViewController {
//    func setupUI() {
//        view.backgroundColor = .systemBackground
//        view.addSubview(scrollView)
//        scrollView.addSubview(stackView)
//        stackView.addArrangedSubview(firstTitleLabel)
//        stackView.addArrangedSubview(shapeStackView)
//        shapeStackView.addArrangedSubview(circle)
//        shapeStackView.addArrangedSubview(rectangular)
//        shapeStackView.addArrangedSubview(UIView())
//        stackView.addArrangedSubview(secondTitleLabel)
//        stackView.addArrangedSubview(scaleAsoectFitImage)
//
//        NSLayoutConstraint.activate([
//            // scrollView Constraint
//            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
//            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//
//            // stackView Constraint
//            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
//
//            // shapeStackView Constraint
//            shapeStackView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
//            shapeStackView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
//
//            // circle Constraint
//            circle.widthAnchor.constraint(equalToConstant: circleRadius * 2),
//            circle.heightAnchor.constraint(equalToConstant: circleRadius * 2),
//
//            // rectangular Constraint
//            rectangular.widthAnchor.constraint(equalToConstant: rectangularSize.width),
//            rectangular.heightAnchor.constraint(equalToConstant: rectangularSize.height),
//        ])
//    }
//}


import UIKit

// MARK: - Declare Components
class UIImageViewController: UIViewController {
    
    private let circleRadius: CGFloat = 40
    private let rectangularSize: CGSize = .init(width: 80, height: 80)
    
    private lazy var scrollView: UIScrollView = buildScrollView()
    private lazy var containerView: UIView = buildContainerView()
    private lazy var stackView: UIStackView = buildStackView(axis: .vertical)
    private lazy var firstTitleLabel: UILabel = buildLabel(title: "1. 도형 그리기")
    private lazy var shapeStackView: UIStackView = buildStackView(axis: .horizontal)
    private lazy var circle: UIView = buildCircle()
    private lazy var rectangular: UIView = buildRectangular()
    private lazy var secondTitleLabel: UILabel = buildLabel(title: "2. 이미지 넣기")
    private lazy var scaleAspectFitImage: UIImageView = buildImageView(imageName: "car", contentMode: .scaleAspectFill)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - Define Components
private extension UIImageViewController {
    
    func buildScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }
    
    func buildStackView(axis: NSLayoutConstraint.Axis) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = axis
        stackView.spacing = 18
        return stackView
    }
    
    func buildLabel(title: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = title
        label.font = .systemFont(ofSize: 24)
        return label
    }
    
    func buildCircle() -> UIView {
        let circle = UIView()
        circle.translatesAutoresizingMaskIntoConstraints = false
        circle.backgroundColor = UIColor.blue
        circle.layer.borderColor = UIColor.black.cgColor
        circle.layer.cornerRadius = circleRadius
        circle.layer.borderWidth = 2
        return circle
    }
    
    func buildRectangular() -> UIView {
        let rectangular = UIView()
        rectangular.translatesAutoresizingMaskIntoConstraints = false
        rectangular.backgroundColor = UIColor.yellow
        rectangular.layer.borderWidth = 2
        rectangular.layer.borderColor = UIColor.black.cgColor
        return rectangular
    }
    
    func buildImageView(imageName: String, contentMode: UIImageView.ContentMode) -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = contentMode
        return imageView
    }
    
    func buildContainerView() -> UIView {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.clipsToBounds = true
        return containerView
    }
}

// MARK: - Lay out UI
extension UIImageViewController {
    func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        containerView.addSubview(firstTitleLabel)
        containerView.addSubview(shapeStackView)
        
        shapeStackView.addArrangedSubview(circle)
        shapeStackView.addArrangedSubview(rectangular)
        
        stackView.addArrangedSubview(containerView)
        stackView.addArrangedSubview(secondTitleLabel)
        stackView.addArrangedSubview(scaleAspectFitImage)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            
            circle.widthAnchor.constraint(equalToConstant: circleRadius * 2),
            circle.heightAnchor.constraint(equalToConstant: circleRadius * 2),
            
            rectangular.widthAnchor.constraint(equalToConstant: rectangularSize.width),
            rectangular.heightAnchor.constraint(equalToConstant: rectangularSize.height)
        ])
        
        NSLayoutConstraint.activate([
            firstTitleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            firstTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            firstTitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            shapeStackView.topAnchor.constraint(equalTo: firstTitleLabel.bottomAnchor, constant: 8),
            shapeStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
//            shapeStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            shapeStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
}
