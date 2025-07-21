//
//  CoreDataStack.swift
//  GlobantChallenge2025
//
//  Created by Jhonatan David Chaparro Alvarez on 18/07/25.
//

// Data/CoreData/CoreDataStack.swift

import CoreData

enum CoreDataStack {
    static let container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FavoriteMovie")
        container.loadPersistentStores { _, error in
            _ = error.map { print("❌ CoreData load error:", $0.localizedDescription) }
        }
        return container
    }()

    static var context: NSManagedObjectContext {
        container.viewContext
    }

    static func save() {
        try? context.save()
    }
}


