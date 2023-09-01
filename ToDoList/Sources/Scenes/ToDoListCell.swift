//
//  ToDoListCell.swift
//  ToDoList
//
//  Created by Ваня Сокол on 01.09.2023.
//

import UIKit

class ToDoListCell: UITableViewCell {
    static let identifier = "cell"

    private let label = UILabel()
    private let detailLabel = UILabel()
    private let image = UIImageView()

    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUIElements()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup UI
    private func setupUIElements() {
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false

        detailLabel.adjustsFontSizeToFitWidth = true
        detailLabel.textColor = .secondaryLabel
        detailLabel.translatesAutoresizingMaskIntoConstraints = false

        image.image = UIImage(systemName: "checkmark.square")
        image.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupLayout() {
        contentView.addSubview(image)
        contentView.addSubview(label)
        contentView.addSubview(detailLabel)

        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            image.heightAnchor.constraint(equalToConstant: 42),
            image.widthAnchor.constraint(equalTo: image.heightAnchor),

            label.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 16),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            label.heightAnchor.constraint(equalToConstant: 18),

            detailLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 16),
            detailLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 6),
            detailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            detailLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }

    // MARK: - Configure
    public func configureCell(with model: ToDoListItem) {
        label.text = model.name?.capitalized
        detailLabel.text = model.createdAt?.format()
        image.tintColor = model.isCompleted ? .systemOrange : .lightGray.withAlphaComponent(0.5)
    }

    // MARK: - Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        detailLabel.text = nil
    }
}
