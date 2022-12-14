//
//  Persistence.swift
//  refo_watch
//
//  Created by Bryan Kenneth on 28/07/22.
//

import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentCloudKitContainer(name: "ResourcesList")
        
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Unresolved Error: \(error)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
}
