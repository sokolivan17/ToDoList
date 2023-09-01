//
//  TableViewCell.swift
//  ToDoList
//
//  Created by Ваня Сокол on 01.09.2023.
//

import UIKit

class TableViewCell: UITableViewCell {
    static let identifier = "cell"

    private let label = UILabel()
    private let detailLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupLabels()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private func setupLabels() {
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false

        detailLabel.adjustsFontSizeToFitWidth = true
        detailLabel.textColor = .secondaryLabel
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupLayout() {
        contentView.addSubview(label)
        contentView.addSubview(detailLabel)

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            label.heightAnchor.constraint(equalToConstant: 18),

            detailLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            detailLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 6),
            detailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            detailLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    public func configureCell(with model: ToDoListItem) {
        label.text = model.name?.capitalized
        detailLabel.text = model.createdAt?.format()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        detailLabel.text = nil
    }
}
