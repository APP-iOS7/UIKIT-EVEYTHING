//
//  MainTableViewController.swift
//  UIKitEveryThing
//
//  Created by 김용해 on 3/13/25.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    // ** 초기 데이터 **
    private(set) var data: [ListTile] = [
        ListTile(title: "Branch Yonghae : UIView", route: YonghaeUIView(receivedTitle: "UIView")),
        ListTile(title: "UITest", route: UILabelViewController()),
        ListTile(title: "ImageView", route: UIImageViewController())
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
    // ** 초기 설정 **
    private func setUpUI() {
        navigationItem.title = "UIKIT EVERYTING"
        let backButton: UIBarButtonItem = UIBarButtonItem()
        backButton.title = "뒤로가기"
        navigationItem.backBarButtonItem = backButton
    }
    
    // ** Section 개수
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // ** 로우 개수**
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    // dataSource 전달 : Cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var config = UIListContentConfiguration.subtitleCell()
        config.text = data[indexPath.row].title
        cell.contentConfiguration = config
        
        return cell
    }
    
    // Table Cell을 선택 했을 경우 will 이기에 선택하기 전? did의 경우 focus animation이 보임
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let route: UIViewController = data[indexPath.row].route
        navigationController?.pushViewController(route, animated: true)
        
        return nil
    }
}

/// private(set)은 읽기 , 쓰기 가 해당 파일에선 가능하지만
/// 다른 파일에서는 읽기만 가능하게 해서 데이터의 무결성을 지킬 수 있다!
/// 주의 할점은 보틍 변수 선언을 let으로 하는데 이 부분은 **충돌이 있다!!**
/// let 은 readOnly이지만 private(set)은 해당 파일에서 읽기 , 쓰기 둘다 되니 충돌하는 것이다.
