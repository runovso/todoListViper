//
//  ToDoCellView.swift
//  ToDoList
//
//  Created by Sergei Runov on 26.08.2024.
//

import UIKit

final class ToDoCellView: UIView {
    
    // MARK: - Static properties
    
    static let reuseIdentifier = "ToDoCell"
    
    // MARK: - Subviews
    
    private let rowStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .firstBaseline
        stack.spacing = 8
        stack.distribution = .fill
        return stack
    }()
    
    private let isCompletedButton: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
        
    private let textStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 4
        return stack
    }()
    
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let dateLabel = UILabel()
    
    private let goToDetailsButton: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Properties
    
    private let task: TaskModel

    // MARK: - Initialization
    
    init(task: TaskModel) {
        self.task = task
        super.init(frame: .zero)
        setupHierarchy()
        setupAppearance()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ToDoCellView {
    
    // MARK: - UI Methods
    
    private func setupHierarchy() {
        addSubview(rowStack)
        
        [isCompletedButton, textStack, goToDetailsButton]
            .forEach { rowStack.addArrangedSubview($0) }
                
        [titleLabel, descriptionLabel, dateLabel]
            .forEach { textStack.addArrangedSubview($0) }
    }
    
    private func setupAppearance() {
        isCompletedButton.tintColor = task.isCompleted ? .systemBlue : .gray
        isCompletedButton.image = task.isCompleted ? UIImage(systemName: "circle.inset.filled") : UIImage(systemName: "circle")
                
        titleLabel.font = .preferredFont(forTextStyle: .title3)
        titleLabel.textColor = task.isCompleted ? .secondaryLabel : .label
        titleLabel.text = task.title
        
        descriptionLabel.font = .preferredFont(forTextStyle: .body)
        descriptionLabel.textColor = .secondaryLabel
        descriptionLabel.text = task.descrption
        
        dateLabel.font = .preferredFont(forTextStyle: .body)
        dateLabel.textColor = .secondaryLabel
        dateLabel.text = "Created at " + task.createdAt.formatted(date: .abbreviated, time: .omitted)
        
        goToDetailsButton.tintColor = .systemGreen
        goToDetailsButton.image = UIImage(systemName: "info.circle")
    }
    
    private func setupConstraints() {
        [rowStack, isCompletedButton, textStack, titleLabel, descriptionLabel, dateLabel, goToDetailsButton]
            .forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            rowStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            rowStack.topAnchor.constraint(equalTo: topAnchor),
            rowStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            rowStack.bottomAnchor.constraint(equalTo: bottomAnchor),

            isCompletedButton.widthAnchor.constraint(equalToConstant: 24),
            isCompletedButton.heightAnchor.constraint(equalToConstant: 24),
            
            goToDetailsButton.widthAnchor.constraint(equalToConstant: 24),
            goToDetailsButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
}

#Preview {
    let cell = ToDoCellView(task: .init(id: 1,
                                        title: "Todo title",
                                        descrption: "Optional description",
                                        createdAt: .now,
                                        isCompleted: false))
    return cell
}
