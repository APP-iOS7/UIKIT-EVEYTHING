//
//  TomDataManager.swift
//  UIKitEveryThing
//
//  Created by 최범수 on 2025-03-25.
//

import Foundation
import CoreData

class TomDataManager {
    static let shared = TomDataManager()
    
    private init() { }
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "TomDataModel")
        
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Failed to load persistent stores: \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
}
