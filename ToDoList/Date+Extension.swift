//
//  Date+Extension.swift
//  ToDoList
//
//  Created by Ваня Сокол on 01.09.2023.
//

import Foundation

extension Date {
    func format() -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .medium
        return formatter.string(from: self)
    }
}
