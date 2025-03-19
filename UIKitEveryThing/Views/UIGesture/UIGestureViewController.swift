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
  private lazy var star: UIImageView = buildStar()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupGesture()
  }
}

// Define Components
extension UIGestureViewController {

  fileprivate func buildRectangular() -> UIView {
    let rect = UIView()
    rect.translatesAutoresizingMaskIntoConstraints = false
    rect.layer.borderWidth = 2
    rect.layer.borderColor = UIColor.black.cgColor
    rect.backgroundColor = .lightGray
    return rect
  }

  fileprivate func buildStar() -> UIImageView {
    let star = UIImageView(image: UIImage(systemName: "star.fill"))
    star.translatesAutoresizingMaskIntoConstraints = false
    star.tintColor = .yellow
    //        star.layer.borderColor = UIColor.black.cgColor
    //        star.layer.borderWidth = 2
    star.isUserInteractionEnabled = true
    return star
  }

}

// Lay out UI
extension UIGestureViewController {
  fileprivate func setupUI() {
    self.view.backgroundColor = .systemBackground
    self.view.addSubview(rectangular)
    self.view.addSubview(star)

    NSLayoutConstraint.activate([
      star.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      star.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
      star.widthAnchor.constraint(equalToConstant: 80),
      star.heightAnchor.constraint(equalToConstant: 80),

      rectangular.topAnchor.constraint(equalTo: star.bottomAnchor, constant: 50),
      rectangular.leadingAnchor.constraint(equalTo: star.leadingAnchor),
      rectangular.widthAnchor.constraint(equalToConstant: 80),
      rectangular.heightAnchor.constraint(equalToConstant: 80),
    ])
  }
}

// Set up Gesture
extension UIGestureViewController: UIGestureRecognizerDelegate {
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

    let pinchGesture = UIPinchGestureRecognizer()
    pinchGesture.addTarget(self, action: #selector(pinchDidExecuted))

    let rotationGesture = UIRotationGestureRecognizer()
    rotationGesture.addTarget(self, action: #selector(rotationGestureExecuted))

    let penGesture = UIPanGestureRecognizer()
    penGesture.addTarget(self, action: #selector(penGestureDidExecute))

    tapGesture.delegate = self
    doubleTapGestures.delegate = self
    pinchGesture.delegate = self
    penGesture.delegate = self

    star.addGestureRecognizer(pinchGesture)
    star.addGestureRecognizer(rotationGesture)
    star.addGestureRecognizer(penGesture)
  }

  @objc func handleTapGesture() {
    print("Tapped")
    dump(self.view.subviews)
  }

  @objc func handleDoubleTapGesture() {
    print("Double Tapped")
  }

  @objc func pinchDidExecuted(_ gesture: UIPinchGestureRecognizer) {
    guard let view = gesture.view else { return }
    view.transform = view.transform.scaledBy(x: gesture.scale, y: gesture.scale)
    gesture.scale = 1.0
  }

  @objc func rotationGestureExecuted(_ gesture: UIRotationGestureRecognizer) {
    guard let view = gesture.view else { return }
    view.transform = view.transform.rotated(by: gesture.rotation)
    gesture.rotation = 0
  }

  @objc func penGestureDidExecute(_ gesture: UIPanGestureRecognizer) {
    guard let view = gesture.view else { return }
    view.center.x += gesture.translation(in: nil).x
    view.center.y += gesture.translation(in: nil).y
    gesture.setTranslation(.zero, in: nil)
  }

  func gestureRecognizer(
    _ gestureRecognizer: UIGestureRecognizer,
    shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
  ) -> Bool {
    true
  }
}

// Code of instructor
private class ViewController: UIViewController, UIGestureRecognizerDelegate {

  var imageView: UIImageView!

  override func viewDidLoad() {
    super.viewDidLoad()

    setupUI()
    setupGesture()
  }

  func setupUI() {
    imageView = UIImageView(image: UIImage(systemName: "star.fill"))
    imageView.tintColor = .systemBlue
    imageView.contentMode = .scaleAspectFit
    imageView.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
    imageView.isUserInteractionEnabled = true
    view.addSubview(imageView)
  }

  func setupGesture() {
    // 여러 제스처 인식기 생성
    let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture))
    let rotationGesture = UIRotationGestureRecognizer(
      target: self, action: #selector(handleRotationGesture))
    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))

    // 제스처 인식기 추가
    imageView.addGestureRecognizer(pinchGesture)
    imageView.addGestureRecognizer(rotationGesture)
    imageView.addGestureRecognizer(panGesture)

    // Delegate 설정
    pinchGesture.delegate = self
    rotationGesture.delegate = self
    panGesture.delegate = self
  }

  @objc func handlePinchGesture(_ pinchGesture: UIPinchGestureRecognizer) {
    // 핀치 제스처 처리 코드
    guard let view = pinchGesture.view else { return }

    view.transform = view.transform.scaledBy(
      x: pinchGesture.scale,
      y: pinchGesture.scale
    )
    pinchGesture.scale = 1.0
  }

  @objc func handleRotationGesture(_ rotationGesture: UIRotationGestureRecognizer) {
    // 회전 제스처 처리 코드
    guard let view = rotationGesture.view else { return }

    view.transform = view.transform.rotated(by: rotationGesture.rotation)
    rotationGesture.rotation = 0
  }

  @objc func handlePanGesture(_ panGesture: UIPanGestureRecognizer) {
    // 팬 제스처 처리 코드
    guard let view = panGesture.view else { return }

    let translation = panGesture.translation(in: view.superview)
    view.center.x += translation.x
    view.center.y += translation.y
    panGesture.setTranslation(.zero, in: view.superview)
  }

  func gestureRecognizer(
    _ gestureRecognizer: UIGestureRecognizer,
    shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
  ) -> Bool {
    return true
  }
}

#Preview {
  ViewController()
}
