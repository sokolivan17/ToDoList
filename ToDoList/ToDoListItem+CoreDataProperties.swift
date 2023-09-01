//
//  ToDoListItem+CoreDataProperties.swift
//  ToDoList
//
//  Created by Ваня Сокол on 01.09.2023.
//
//

import Foundation
import CoreData

@objc(ToDoListItem)
public class ToDoListItem: NSManagedObject { }

extension ToDoListItem {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoListItem> {
        return NSFetchRequest<ToDoListItem>(entityName: "ToDoListItem")
    }

    @NSManaged public var name: String?
    @NSManaged public var createdAt: Date?

}

extension ToDoListItem: Identifiable { }
