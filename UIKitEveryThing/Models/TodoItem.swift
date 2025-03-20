//
//  TodoItem.swift
//  UIKitEveryThing
//
//  Created by 김용해 on 3/20/25.
//

import CoreData

struct Todo: Hashable {
    let id: UUID
    let title: String
    
    init(id: UUID, title: String) {
        self.id = id
        self.title = title
    }
    
    init(title: String) {
        self.id = UUID()
        self.title = title
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Todo, rhs: Todo) -> Bool {
        lhs.id == rhs.id
    }
}


extension Todo {
    // ** Todo -> TodoItem으로 변환
    func toManagedObject(in context: NSManagedObjectContext) -> TodoItem {
        let entity = TodoItem(context: context)
        entity.id = id
        entity.title = title
        entity.createdAt = Date()
        
        return entity
    }
    
    // TodoItem -> Todo로 변환
    func from(todoItem: TodoItem) -> Todo? {
        guard let id = todoItem.id,
              let title = todoItem.title else { return nil }
        
        return Todo(id: id, title: title)
    }
}
