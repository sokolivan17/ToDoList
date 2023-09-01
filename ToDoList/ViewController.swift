//
//  ViewController.swift
//  ToDoList
//
//  Created by Ваня Сокол on 01.09.2023.
//

import UIKit

class ViewController: UIViewController {
    private var models = [ToDoListItem]()

    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "To Do List"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true

        models = CoreDataManager.shared.getAllItems()

        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(didTapAdd))
    }

    @objc private func didTapAdd() {
        let alert = UIAlertController(title: "New Item",
                                      message: "Enter new item",
                                      preferredStyle: .alert)
        alert.addTextField()
        alert.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: { [weak self] _ in
            guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else {
                return
            }

            CoreDataManager.shared.createItem(name: text) {
                self?.models = CoreDataManager.shared.getAllItems()
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }))

        present(alert, animated: true)
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model.name
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = models[indexPath.row]

        let sheet = UIAlertController(title: "Edit",
                                      message: nil,
                                      preferredStyle: .actionSheet)

        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        sheet.addAction(UIAlertAction(title: "Edit", style: .default, handler: { [weak self] _ in
            let alert = UIAlertController(title: "Edit Item",
                                          message: "Edit your item",
                                          preferredStyle: .alert)
            alert.addTextField()
            alert.textFields?.first?.text = item.name
            alert.addAction(UIAlertAction(title: "Save", style: .cancel, handler: { [weak self] _ in
                guard let field = alert.textFields?.first, let newName = field.text, !newName.isEmpty else {
                    return
                }

                CoreDataManager.shared.updateItem(item: item, newName: newName) {
                    self?.models = CoreDataManager.shared.getAllItems()
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                }
            }))

            self?.present(alert, animated: true)
        }))

        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
            CoreDataManager.shared.deleteItem(item: item) {
                self?.models = CoreDataManager.shared.getAllItems()
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }))

        present(sheet, animated: true)
    }
}
