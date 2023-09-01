//
//  ViewController.swift
//  ToDoList
//
//  Created by Ваня Сокол on 01.09.2023.
//

import UIKit

class ViewController: UIViewController {
    private var models = [ToDoListItem]()
    private let tableView = UITableView()

    // MARK: - Lifecycyle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "To Do List"
        view.backgroundColor = .systemBackground
        setupNavigationBar()

        models = CoreDataManager.shared.getAllItems()

        setupTableView()
    }

    // MARK: - Setup Navigation Bar
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(didTapAdd))
    }

    // MARK: - Setup Table View
    private func setupTableView() {
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self

        view.addSubview(tableView)

        tableView.frame = view.bounds
    }

    // MARK: - Setup Alert
    private func setupAlert(with item: ToDoListItem) {
        let sheet = UIAlertController(title: "Choose Action",
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

    // MARK: - Actions
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

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier,
                                                       for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        cell.configureCell(with: model)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = models[indexPath.row]

        setupAlert(with: item)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 58
    }
}
