//
//  ViewController.swift
//  ToDoList
//
//  Created by Ваня Сокол on 01.09.2023.
//

import UIKit

class ViewController: UIViewController {
    private var models = CoreDataManager.shared.models

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "To Do List"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

