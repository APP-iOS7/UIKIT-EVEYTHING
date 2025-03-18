//
//  YonghaeUIImageController.swift
//  UIKitEveryThing
//
//  Created by 김용해 on 3/17/25.
//
import UIKit

class YonghaeUIImageController: UIViewController {
    
    private lazy var scrollView = UIScrollView()
    private lazy var stackView = UIStackView()
    
    
    private lazy var firstStackView: UIStackView = {
        let firstStackView: UIStackView = UIStackView()
        firstStackView.translatesAutoresizingMaskIntoConstraints = false
        firstStackView.isLayoutMarginsRelativeArrangement = true
        firstStackView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        firstStackView.axis = .horizontal
        firstStackView.backgroundColor = .gray
        firstStackView.alignment = .center
        firstStackView.distribution = .equalCentering
        
        return firstStackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // 전체를 감싸는 Layout Scroll
        setUpStackView()
        // 첫번째 도형 레이아웃
        setUpFirst()
        // 두번째 이미지 데모 레이아웃
        let container1: UIStackView = setUpImage(title: "2. 이미지 레이아웃Fit", scaleMode: .scaleAspectFit, personStackView: firstStackView)
        // 세번째 이미지 데모 레이아웃
        let container2: UIStackView = setUpImage(title: "3. 이미지 레이아웃Fill", scaleMode: .scaleAspectFill, personStackView: container1)
        // 네번째 이미지 데모 레이아웃
        let _: UIStackView = setUpImage(title: "4. 이미지 레이아웃ToFill", scaleMode: .scaleToFill, personStackView: container2)
        
    }
    // MARK: 전체를 감싸는 Scroll, Stack
    private func setUpStackView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 20
        
        scrollView.addSubview(stackView)
        self.view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            // 스크롤뷰 제약
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),

            // StackView 제약
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
    }

    // MARK: 첫번째 도형 레이아웃
    private func setUpFirst() {
        let label: UILabel = UILabel()
        label.text = "1. 도형 모양"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24)

        let circle: UIView = UIView()
        let circleSize: CGFloat = 80
        circle.translatesAutoresizingMaskIntoConstraints = false
        circle.layer.cornerRadius = circleSize / 2
        circle.backgroundColor = .systemRed
        
        let rectangle: UIView = UIView()
        let rectangleSize: CGFloat = 80
        rectangle.translatesAutoresizingMaskIntoConstraints = false
        rectangle.layer.cornerRadius = 8
        rectangle.backgroundColor = .systemBlue
        
        firstStackView.addArrangedSubview(circle)
        firstStackView.addArrangedSubview(rectangle)
        
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(firstStackView)
        
        NSLayoutConstraint.activate([
            // 첫번째 stackView Row
            firstStackView.topAnchor.constraint(equalTo: label.bottomAnchor),
            firstStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            firstStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            firstStackView.heightAnchor.constraint(equalToConstant: 100),
            // circle 크기
            circle.widthAnchor.constraint(equalToConstant: circleSize),
            circle.heightAnchor.constraint(equalToConstant: circleSize),
            // 정사각형 크기
            rectangle.widthAnchor.constraint(equalToConstant: rectangleSize),
            rectangle.heightAnchor.constraint(equalToConstant: rectangleSize)
        ])
    }
    
    // MARK: 중복되는 이미지 레이아웃
    private func setUpImage(title: String, scaleMode: UIImageView.ContentMode, personStackView: UIStackView) -> UIStackView {
        // 라벨 생성
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = title
        label.font = .systemFont(ofSize: 24)
        
        // 컨테이너 생성
        let container: UIStackView = UIStackView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.axis = .vertical
        container.backgroundColor = .green
        
        // 이미지를 위한 UIView 생성
        let imageContainer: UIView = UIView()
        imageContainer.translatesAutoresizingMaskIntoConstraints = false
        imageContainer.backgroundColor = .green
        
        // 실제 이미지
        let imageView: UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "car")
        imageView.contentMode = scaleMode
        imageContainer.addSubview(imageView)
        
        container.addArrangedSubview(label)
        container.addArrangedSubview(imageContainer)
        
        stackView.addArrangedSubview(container)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: personStackView.bottomAnchor, constant: 20),
            container.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            container.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            // 이미지 constraint
            imageContainer.heightAnchor.constraint(equalToConstant: 200),
            imageView.topAnchor.constraint(equalTo: imageContainer.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: imageContainer.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: imageContainer.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        return container
    }
}

#Preview {
    YonghaeUIImageController()
}



/// ** MARK: 회고 (3월 17일 수업)
///
/// 저는 다시 한번 해보면서 구조를 생각해봤는데요
/// 순서는  scrollView <- stackView <- label <- firstStackView <- container(label, stackview)
/// 스크롤이 계속 늘어나는 이유는 scrollView가  self.view의 영역을 통해 audoLayout하는데 그 하위에 label이 self.view의 top앵커를 기준이여서 이상하게 스크롤되는 현상을 보았습니다 ㅠㅠ 앞으로는 이렇게 구조를 설계하고 제약조건을 설정할때는 확실한 기준을 세우고 하는게 좋을거 같습니다 :)
