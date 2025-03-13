//
//  MainTableViewController.swift
//  UIKitEveryThing
//
//  Created by 김용해 on 3/13/25.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    // ** 초기 데이터 **
    let data: [ListTile] = [
        ListTile(title: "Test용 라우트 입니다?", route: TestController(receivedTitle: "Test용 라우트 입니다?"))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    // ** 초기 설정 **
    func setUpUI() {
        navigationItem.title = "UIKIT EVERYTING"
    }
    
    // ** Section 개수
    override func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
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


