//
//  YonghaeCollectionView.swift
//  UIKitEveryThing
//
//  Created by 김용해 on 3/24/25.
//

import UIKit
import SwiftUI

class YonghaeCollectionView: UIViewController {
    
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setUpCollectionView()
    }
    
    // MARK: 초기 설정
    private func setUpUI() {
        self.view.backgroundColor = .white
        self.title = "YonghaeCollectionView"
    }
    
    // MARK: CollectionView 설정
    private func setUpCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.bounds.width - 50, height: 100)
        layout.minimumLineSpacing = 50
        layout.minimumInteritemSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        collectionView.collectionViewLayout = layout
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        self.view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
}

// MARK: Collection Delegate, DataSource
extension YonghaeCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        if #available(iOS 16.0, *) { // 스유랑 합작한 코드
            cell.contentConfiguration = UIHostingConfiguration {
                HStack(alignment: .center) {
                    Image(systemName: "star").foregroundStyle(.red)
                    VStack(alignment: .leading) {
                        Text("내가 좋아하는건..")
                            .font(.title)
                        Text("이거 호이스팅 맛있네..?")
                            .font(.body)
                    }
                    .padding()
                    Spacer()
                }
//                .frame(width: cell.bounds.width, height: cell.bounds.height)
                .padding()
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }else { // UIKit으로 구성한 UICollectionViewCell
            let customView: UIView = {
                let uiview = UIView(frame: cell.contentView.bounds)
                uiview.backgroundColor = .systemBlue
                uiview.layer.cornerRadius = 12
                uiview.clipsToBounds = true
                return uiview
            }()
            let starImage: UIImageView = {
                let image = UIImageView(image: UIImage(systemName: "star"))
                image.tintColor = .systemRed
                image.contentMode = .scaleAspectFit
                image.translatesAutoresizingMaskIntoConstraints = false
                return image
            }()
            let titleLabel: UILabel = {
                let label = UILabel()
                label.translatesAutoresizingMaskIntoConstraints = false
                label.text = "내가 좋아하는건.."
                label.font = .systemFont(ofSize: 20, weight: .bold)
                return label
            }()
            let subtitleLabel: UILabel = {
                let subLabel = UILabel()
                subLabel.text = "이거 호이스팅 맛있네..?"
                subLabel.font = .systemFont(ofSize: 16)
                return subLabel
            }()
            let textStackView: UIStackView = {
                let stackview = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
                stackview.axis = .vertical
                stackview.alignment = .leading
                stackview.spacing = 4
                stackview.translatesAutoresizingMaskIntoConstraints = false
                return stackview
            }()
            let containerStackView: UIStackView = {
                let stackview = UIStackView(arrangedSubviews: [starImage, textStackView])
                stackview.axis = .horizontal
                stackview.alignment = .center
                stackview.spacing = 8
                stackview.translatesAutoresizingMaskIntoConstraints = false
                return stackview
            }()
            customView.addSubview(containerStackView)
            cell.contentView.addSubview(customView)
            
            NSLayoutConstraint.activate([
                containerStackView.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 10),
                containerStackView.trailingAnchor.constraint(lessThanOrEqualTo: customView.trailingAnchor, constant: -10),
                containerStackView.topAnchor.constraint(equalTo: customView.topAnchor, constant: 10),
                containerStackView.bottomAnchor.constraint(equalTo: customView.bottomAnchor, constant: -10),
                starImage.widthAnchor.constraint(equalToConstant: 24),
                starImage.heightAnchor.constraint(equalToConstant: 24)
            ])
        }
        
        return cell
    }
}


/// ** 오늘의 목표
///
/// 1. UICollectionViewDiffableDataSource 알아보기  --> 언젠간 합니다 언젠간...
/// 2. IOS 16부터 사용가능한 호이스팅을 알아보기
/// UIHostingConfiguration을 사용해서 굉장히 간결하게 스유의 코드로 View를 구성할 수 있지만  autoLayout의 강력함이 없다는 점이 단점으로 보였습니다
///
///  반대로 UIKit만으로 구성한 cell은 굉장히 긴 코드였지만 확실히 autoLayout이 잘 잡아주고 있다는 점을 확인 할 수 있습니다
