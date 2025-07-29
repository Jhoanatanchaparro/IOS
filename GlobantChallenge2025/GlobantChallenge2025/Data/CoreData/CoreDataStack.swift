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
            if let error = error {
                fatalError("❌ Error al cargar CoreData: \(error.localizedDescription)")
            }
        }
        return container
    }()

    static var context: NSManagedObjectContext {
        container.viewContext
    }

    static func save() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("❌ Error al guardar en CoreData:", error.localizedDescription)
            }
        }
    }
}


