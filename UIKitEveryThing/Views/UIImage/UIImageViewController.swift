//
//  UIImageViewController.swift
//  UIKitEveryThing
//
//  Created by 최범수 on 2025-03-17.
//

import UIKit

// MARK: - Declare Components
class UIImageViewController: UIViewController {
    
    private let circleRadius: CGFloat = 40
    private let rectangularSize: CGSize = .init(width: 80, height: 80)
    
    private lazy var scrollView: UIScrollView = buildScrollView()
    private lazy var stackView: UIStackView = buildStackView(axis: .vertical)
    private lazy var firstTitleLabel: UILabel = buildLabel(title: "1. 도형 그리기")
    private lazy var shapeStackView: UIStackView = buildStackView(axis: .horizontal)
    private lazy var circle: UIView = buildCircle()
    private lazy var rectangular: UIView = buildRectangular()
    private lazy var secondTitleLabel: UILabel = buildLabel(title: "2. 이미지 넣기")
    private lazy var scaleAsoectFitImage: UIImageView = buildImageView(imageName: "car", contentMode: .scaleAspectFit)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

//MARK: - Define Components
private extension UIImageViewController {
    
    func buildScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }
    
    func buildStackView(axis: NSLayoutConstraint.Axis) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.distribution = 
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
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
}

// MARK: - Lay out UI
private extension UIImageViewController {
    func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(firstTitleLabel)
        stackView.addArrangedSubview(shapeStackView)
        shapeStackView.addArrangedSubview(circle)
        shapeStackView.addArrangedSubview(rectangular)
        stackView.addArrangedSubview(secondTitleLabel)
        stackView.addArrangedSubview(scaleAsoectFitImage)
        
        NSLayoutConstraint.activate([
            // scrollView Constraint
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            // stackView Constraint 여기서 왜 앵커가 안먹을까??
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // shapeStackView Constraint
            shapeStackView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
//            shapeStackView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            // circle Constraint
            circle.widthAnchor.constraint(equalToConstant: circleRadius * 2),
            circle.heightAnchor.constraint(equalToConstant: circleRadius * 2),
            
            // rectangular Constraint
            rectangular.widthAnchor.constraint(equalToConstant: rectangularSize.width),
            rectangular.heightAnchor.constraint(equalToConstant: rectangularSize.height)
        ])
    }
    
}
//
//  ViewController.swift
//  ImageDemo
//
//  Created by jshin on 3/17/25.
//
//
//import UIKit
//
//class UIImageViewController: UIViewController {
//
//  let scrollView = UIScrollView()
//  let stackView = UIStackView()
//
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    // Do any additional setup after loading the view.
//
//    // UI 설정 (기본 스크롤과 스택 뷰 추가)
//    setupUI()
//
//    // 기본 도형 표시
//    setupShapes()
//
//    // 이미지 표시
//    setupImages()
//
//    // 이미지 컨텐츠 모드
//    setupImageContentMode()
//
//    // SF Symbol 표시
//    setupSFSymbols()
//  }
//
//  // MARK: - UI 설정 (기본 스크롤과 스택 뷰 추가)
//  func setupUI() {
//    // 스크롤 뷰 설정
//    scrollView.translatesAutoresizingMaskIntoConstraints = false
//    view.addSubview(scrollView)
//
//    // 스택 뷰 설정
//    stackView.axis = .vertical
//    stackView.spacing = 20
//    stackView.translatesAutoresizingMaskIntoConstraints = false
//    scrollView.addSubview(stackView)
//
//    // 제약조건 설정
//    NSLayoutConstraint.activate([
//      // 스크롤 뷰 제약조건 설정
//      scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//      scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//      scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//      scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//
//      // 스택 뷰 제약조건 설정
//      stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
//      stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
//      stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
//      stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
//
//      // 중요: 스택 뷰의 너비를 스크롤 뷰의 너비에 맞춤 (패딩 고려)
//      stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40)
//    ])
//  }
//
//  // MARK: - 기본 도형 표시
//  func setupShapes() {
//    let containerView = UIView()
//
//    // 원 만들기
//    let circleView = UIView()
//    // 크기에 대한 컨텍스트 상수
//    let circleSize: CGFloat = 80
//
//    circleView.translatesAutoresizingMaskIntoConstraints = false
//    circleView.backgroundColor = .yellow
//    circleView.layer.cornerRadius = circleSize / 2
//    circleView.layer.borderWidth = 2
//    circleView.layer.borderColor = UIColor.black.cgColor
//    containerView.addSubview(circleView)
//
//      containerView.translatesAutoresizingMaskIntoConstraints = false
//
//      // 제목 레이블
//      let titleLabel = UILabel()
//      titleLabel.text = "1. 기본 도형"
//      titleLabel.font = .systemFont(ofSize: 24)
//      titleLabel.translatesAutoresizingMaskIntoConstraints = false
//
//      containerView.addSubview(titleLabel)
//      
//        
//        
//      
//    // 사각형 만들기
//    let squareView = UIView()
//    let squareSize: CGFloat = 80
//
//    squareView.translatesAutoresizingMaskIntoConstraints = false
//    squareView.backgroundColor = .blue
//    containerView.addSubview(squareView)
//
//    // 스택 뷰에 컨테이너 뷰 추가
//    stackView.addArrangedSubview(containerView)
//
//    // 제목 레이블, 원, 사각형의 제약조건 설정
//    NSLayoutConstraint.activate([
//      titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
//      titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
//
//      circleView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
//      circleView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
//      circleView.widthAnchor.constraint(equalToConstant: circleSize),
//      circleView.heightAnchor.constraint(equalToConstant: circleSize),
//
//      squareView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
//      squareView.leadingAnchor.constraint(equalTo: circleView.trailingAnchor, constant: 30),
//      squareView.widthAnchor.constraint(equalToConstant: squareSize),
//      squareView.heightAnchor.constraint(equalToConstant: squareSize),
//
//      // 중요: 컨테이너 뷰의 높이 명시적으로 설정 (마지막 요소 기준)
//      containerView.bottomAnchor.constraint(equalTo: circleView.bottomAnchor, constant: 20)
//    ])
//
//  }
//
//  // MARK: - 이미지 표시
//  func setupImages() {
//    let containerView = UIView()
//    containerView.translatesAutoresizingMaskIntoConstraints = false
//
//    // 제목 레이블
//    let titleLabel = UILabel()
//    titleLabel.text = "2. 이미지 표시"
//    titleLabel.font = .systemFont(ofSize: 24)
//    titleLabel.translatesAutoresizingMaskIntoConstraints = false
//
//    containerView.addSubview(titleLabel)
//
//    // 이미지 뷰 생성
//    let imageView = UIImageView()
//    imageView.image = UIImage(named: "car")
//    imageView.contentMode = .scaleAspectFit
//    imageView.translatesAutoresizingMaskIntoConstraints = false
//    containerView.addSubview(imageView)
//
//    // 스택 뷰에 컨테이너 뷰 추가
//    stackView.addArrangedSubview(containerView)
//
//    // 제목 레이블, 이미지 뷰의 제약조건 설정
//    NSLayoutConstraint.activate([
//      titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
//      titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
//
//      imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
//      imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
//      imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
//      imageView.heightAnchor.constraint(equalToConstant: 200),
//
//      // 중요: 컨테이너 뷰의 높이 명시적으로 설정 (마지막 요소 기준)
//      containerView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20)
//    ])
//  }
//
//  // MARK: - 이미지 컨텐츠 모드
//  func setupImageContentMode() {
//    addImageContentModeWith(title: "3. 이미지 컨텐츠 모드 (aspectFill)", contentMode: .scaleAspectFill)
//
//    addImageContentModeWith(title: "4. 이미지 컨텐츠 모드 (aspectFit)", contentMode: .scaleAspectFit)
//
//    addImageContentModeWith(title: "5. 이미지 컨텐츠 모드 (scaleToFill)", contentMode: .scaleToFill)
//  }
//
//  // 이미지 컨텐츠 모드 추가
//  func addImageContentModeWith(title: String, contentMode: UIView.ContentMode) {
//    let containerView = UIView()
//    containerView.translatesAutoresizingMaskIntoConstraints = false
//
//    let titleLabel = UILabel()
//    titleLabel.text = title
//    titleLabel.font = .systemFont(ofSize: 24)
//    titleLabel.translatesAutoresizingMaskIntoConstraints = false
//    containerView.addSubview(titleLabel)
//
//    let imageView = UIImageView()
//    imageView.image = UIImage(named: "car")
//    imageView.backgroundColor = .black
//    imageView.contentMode = contentMode
//    imageView.clipsToBounds = true
//    imageView.translatesAutoresizingMaskIntoConstraints = false
//    containerView.addSubview(imageView)
//
//    NSLayoutConstraint.activate([
//      titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
//      titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
//
//      imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
//      imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
//      imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
//      imageView.heightAnchor.constraint(equalToConstant: 100),
//
//      containerView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20)
//    ])
//
//    stackView.addArrangedSubview(containerView)
//  }
//
//  // MARK: - SF Symbol 표시
//  func setupSFSymbols() {
//    let containerView = UIView()
//    containerView.translatesAutoresizingMaskIntoConstraints = false
//
//    // 제목 레이블
//    let titleLabel = UILabel()
//    titleLabel.text = "6. SF Symbol 표시"
//    titleLabel.font = .systemFont(ofSize: 24)
//    titleLabel.translatesAutoresizingMaskIntoConstraints = false
//
//    containerView.addSubview(titleLabel)
//
//    // SF Symbol 이미지 뷰 생성
//    if #available(iOS 13.0, *) {
//      let imageView = UIImageView()
//      let configuration = UIImage.SymbolConfiguration(pointSize: 100)
//      imageView.image = UIImage(systemName: "hare.fill", withConfiguration: configuration)
//      imageView.tintColor = .purple
//      imageView.contentMode = .scaleAspectFit
//      imageView.translatesAutoresizingMaskIntoConstraints = false
//      containerView.addSubview(imageView)
//
//      // 스택 뷰에 컨테이너 뷰 추가
//      stackView.addArrangedSubview(containerView)
//
//      // 제목 레이블, 이미지 뷰의 제약조건 설정
//      NSLayoutConstraint.activate([
//        titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
//        titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
//
//        imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
//        imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
//        imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
//        imageView.heightAnchor.constraint(equalToConstant: 100),
//
//        // 중요: 컨테이너 뷰의 높이 명시적으로 설정 (마지막 요소 기준)
//        containerView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20)
//      ])
//    }
//  }
//}
//
//#Preview {
//    UIImageViewController()
//}
//
