//
//  CoreDataManager.swift
//  ToDoList
//
//  Created by Ваня Сокол on 01.09.2023.
//

import CoreData
import UIKit

class CoreDataManager {
    public static let shared = CoreDataManager()

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ToDoListModel")
        container.loadPersistentStores { description, error in
            if let error {
                print(error.localizedDescription)
            } else {
                print("DB url -", description.url?.absoluteString)
            }
        }
        return container
    }()

    private var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    private init() { }

    public func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }

    public func getAllItems() -> [ToDoListItem]{
        do {
            return (try? context.fetch(ToDoListItem.fetchRequest()) as? [ToDoListItem]) ?? []
        }
    }

    public func createItem(name: String, completion: () -> ()) {
        let newItem = ToDoListItem(context: context)
        newItem.name = name
        newItem.createdAt = Date()

        do {
            try context.save()
            completion()
        } catch {
            print("Create error",error)
        }
    }

    public func deleteItem(item: ToDoListItem, completion: () -> ()) {
        context.delete(item)

        do {
            try context.save()
            completion()
        } catch {
            print("Delete error",error)
        }
    }

    public func updateItem(item: ToDoListItem, newName: String, completion: () -> ()) {
        item.name = newName

        do {
            try context.save()
            completion()
        } catch {
            print("Update error",error)
        }
    }

}
