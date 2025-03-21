//
//  TodoItem+CoreDataProperties.swift
//  UIKitEveryThing
//
//  Created by 김용해 on 3/21/25.
//
//

import Foundation
import CoreData


extension TodoItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoItem> {
        return NSFetchRequest<TodoItem>(entityName: "TodoItem")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var title: String?

}

extension TodoItem : Identifiable {

}
