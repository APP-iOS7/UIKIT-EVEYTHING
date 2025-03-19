//
//  TodoTableView.swift
//  UIKitEveryThing
//
//  Created by 김용해 on 3/19/25.
//

import UIKit

class YonghaeTodoTableView: UITableViewController {
    var todos: [String] // 데이터 받아오기
    
    // 생성자
    init(todos: [String]) {
        self.todos = todos
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("어차피 안써요~")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Table 쪽 Todos : \(todos)")
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TodoCell")
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateTodos), name: Notification.Name("updateTodo"), object: nil)
    }
    
    // MARK: 알림 이벤트 옵저버
    @objc func updateTodos(_ notification: Notification) {
        if let userinfo = notification.userInfo, let data = userinfo["todos"] as? [String] {
            todos = data
            tableView.reloadData()
            print("todos : \(todos)")
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(Notification.Name("updateTodo"))
    }
}

extension YonghaeTodoTableView {
    // MARK: Row의 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    // MARK: Cell 정의 구현
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)

        var config = UIListContentConfiguration.subtitleCell()
        config.text = todos[indexPath.row]
        cell.insetsLayoutMarginsFromSafeArea = true
        cell.translatesAutoresizingMaskIntoConstraints = false
        cell.contentConfiguration = config
        
        return cell
    }
    // Row : 높이 조절
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

#Preview {
    UINavigationController(rootViewController: YonghaeTodoTableView(todos: ["123", "456","789"]))
}
