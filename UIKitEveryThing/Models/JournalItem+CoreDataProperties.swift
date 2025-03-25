//
//  JournalItem+CoreDataProperties.swift
//  UIKitEveryThing
//
//  Created by 최범수 on 2025-03-25.
//
//

import Foundation
import CoreData


extension JournalItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<JournalItem> {
        return NSFetchRequest<JournalItem>(entityName: "JournalItem")
    }

    @NSManaged public var id: UUID
    @NSManaged public var title: String
    @NSManaged public var content: String
    @NSManaged public var image: Data?
    @NSManaged public var rating: Int
    @NSManaged public var createdAt: Date
    @NSManaged public var journalDate: Date

}

extension JournalItem : Identifiable {

}
