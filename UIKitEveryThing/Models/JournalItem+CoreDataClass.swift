//
//  JournalItem+CoreDataClass.swift
//  UIKitEveryThing
//
//  Created by 최범수 on 2025-03-25.
//
//

import Foundation
import CoreData

@objc(JournalItem)
public class JournalItem: NSManagedObject {
    convenience init(title: String, content: String, journalDate: Date, image: Data? = nil) {
        self.init(context: TomDataManager.shared.context)
        self.id = UUID()
        self.createdAt = Date()
        self.content = content
        self.image = image
        self.rating = 0
        self.journalDate = journalDate
    }
}
