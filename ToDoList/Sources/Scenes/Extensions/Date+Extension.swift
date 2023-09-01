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
        formatter.timeStyle = .short
        formatter.dateStyle = .long
        return formatter.string(from: self)
    }
}
