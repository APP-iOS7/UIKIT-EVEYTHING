//
//  YonghaeCollectionView.swift
//  UIKitEveryThing
//
//  Created by 김용해 on 3/24/25.
//

import UIKit

class YonghaeCollectionView: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    private func setUpUI() {
        self.view.backgroundColor = .white
        self.title = "YonghaeCollectionView"
    }
}



/// ** 오늘의 목표
///
/// 1. UICollectionViewDiffableDataSource 알아보기
/// 2. IOS 16부터 사용가능한 호이스팅을 알아보기
