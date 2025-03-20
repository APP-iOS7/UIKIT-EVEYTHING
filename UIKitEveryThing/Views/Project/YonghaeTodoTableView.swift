//
//  TodoTableView.swift
//  UIKitEveryThing
//
//  Created by 김용해 on 3/19/25.
//

import UIKit

class YonghaeTodoTableView: UITableViewController {
    var todos: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TodoCell")
        
        // 이벤트 수신
        NotificationCenter.default.addObserver(self, selector: #selector(createTodos), name: Notification.Name("createTodos"), object: nil)
    }
    
    // MARK: 알림 이벤트 옵저버 Create
    @objc func createTodos(_ notification: Notification) {
        if let userinfo = notification.userInfo, let data = userinfo["todo"] as? String {
            todos.append(data)
            tableView.reloadData()
            print("todos : \(todos)")
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(Notification.Name("createTodos"))
    }
}
// MARK: delegate 확장
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // 삭제 스와이프
            let todo: String = todos[indexPath.row]
            let filterTodos = todos.filter{ $0 != todo } // 일치하지 않는 todo 전부 가져오기
            deleteTodo(filterTodos: filterTodos) // Delete 함수
        }
    }
}

// MARK: child View 테이블 확장
extension YonghaeTodoTableView {
    // MARK: 해당 투두를 제거하는 함수 (DELETE)
    func deleteTodo(filterTodos: [String]) {
        todos = filterTodos // 소매 넣기
        tableView.reloadData() // 업데이트
    }
}

#Preview {
    UINavigationController(rootViewController: YonghaeTodoTableView())
}
