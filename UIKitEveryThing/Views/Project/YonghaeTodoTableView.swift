//
//  TodoTableView.swift
//  UIKitEveryThing
//
//  Created by 김용해 on 3/19/25.
//
import UIKit
import CoreData

protocol UpdateTextFieldDelegate: AnyObject {
    func updateTodos(todo: Todo)
}


class YonghaeTodoTableView: UITableViewController, UpdateTextFieldDelegate {
    var todos: [Todo] = []
    private var persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    private var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // TableView 초기 설정
        configure()
        // 이벤트 수신
        NotificationCenter.default.addObserver(self, selector: #selector(createTodos), name: Notification.Name("createTodos"), object: nil)
        // 데이터 Reload
        loadTodos()
    }
    // MARK: TableView 설정
    private func configure() {
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TodoCell")
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
        config.text = todos[indexPath.row].title
        config.textProperties.color = UIColor.convertHexColor(red: 217, green: 22, blue: 86)
        cell.backgroundColor = UIColor.convertHexColor(red: 255, green: 178, blue: 0)
        cell.contentConfiguration = config
        
        // 셀 선택 시 배경색을 변경
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = UIColor.convertHexColor(red: 235, green: 91, blue: 0)
        cell.selectedBackgroundView = selectedBackgroundView
        
        return cell
    }
    // MARK: Row : 높이 조절
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    // MARK: Row : DELETE 스와이프
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // 삭제 스와이프
            let todo: Todo = todos[indexPath.row]
            deleteTodo(todo: todo) // Delete 함수
        }
    }
    // MARK: Row : 선택 되었을때 바텀 시트 Open
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = YonghaeTodoDetailVC(currentTodo: todos[indexPath.row])
        let detailNav = UINavigationController(rootViewController: detailVC)
        detailVC.delegate = self
        present(detailNav, animated: true)
    }
}

// MARK: child View 테이블 확장
extension YonghaeTodoTableView {
    // MARK: 알림 이벤트 옵저버
    @objc func createTodos(_ notification: Notification) {
        if let userinfo = notification.userInfo, let data = userinfo["todo"] as? String {
            let todo = Todo(title: data) // Todo 생성
            todos.append(todo)
            saveTodos(todo)
            print("todos : \(todos)")
        }
    }
    
    /// ** ---------- CRUD ------------- **
    
    // MARK: Todo 저장 함수 CREATE
    private func saveTodos(_ item: Todo) {
        let _ = item.toManagedObject(in: viewContext)
        
        do {
            try viewContext.save()
            loadTodos()
        } catch {
            print("아이템 생성시 에러 발생 : \(error)")
        }
    }
    
    // MARK: Todos 업데이트 함수 READ
    private func loadTodos() {
        let request: NSFetchRequest<TodoItem> = TodoItem.fetchRequest()
        
        request.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: true)]
        
        do {
            let result = try viewContext.fetch(request)
            todos = result.compactMap{ Todo.from($0)}
            tableView.reloadData()
        } catch {
            print("loadTodos Error : \(error)")
        }
    }
    
    // MARK: 해당 Text를 바꿔주는 Update함수 (UPDATE)
    func updateTodos(todo: Todo) {
        let request: NSFetchRequest<TodoItem> = TodoItem.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", todo.id as CVarArg)
        
        do {
            let result = try viewContext.fetch(request)
            if let todoItem = result.first {
                todoItem.title = todo.title
            }
            try viewContext.save()
            loadTodos()
        } catch {
            print("업데이트 실패.. ㅠ ㅠ")
        }
    }
    
    // MARK: 해당 투두를 제거하는 함수 (DELETE)
    func deleteTodo(todo: Todo) {
        let request: NSFetchRequest<TodoItem> = TodoItem.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", todo.id as CVarArg)
        
        do {
            let result = try viewContext.fetch(request)
            guard let object = result.first else { return }
            
            viewContext.delete(object)
            try viewContext.save()
            loadTodos() // 업데이트
        } catch {
            print("삭제 과정 중 Error : \(error)")
        }
    }
    
    /// ** ---------- CRUD END ------------- **
}

#Preview {
    UINavigationController(rootViewController: YonghaeTodoTableView())
}
