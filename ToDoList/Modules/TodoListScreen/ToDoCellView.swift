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
            
    private let textStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 2
        return stack
    }()
    
    private let titleTextField = UITextField()
    private let descriptionTextField = UITextField()
    private let dateLabel = UILabel()
    
    private let isCompletedButton = UIButton()
    private let goToDetailsButton = UIButton()
    
    // MARK: - Properties
    
    private let task: TaskModel
    private let presenter: ToDoListViewOutput

    // MARK: - Initialization
    
    init(task: TaskModel, presenter: ToDoListViewOutput) {
        self.task = task
        self.presenter = presenter
        super.init(frame: .zero)
        setupTargetsAndDelegates()
        setupHierarchy()
        setupAppearance()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ToDoCellView {
    
    // MARK: - Configuration methods
    
    private func setupTargetsAndDelegates() {
        isCompletedButton.addTarget(self, action: #selector(didTapIsCompletedButton), for: .touchUpInside)
        goToDetailsButton.addTarget(self, action: #selector(didTapDetailsButton), for: .touchUpInside)
        
        titleTextField.delegate = self
        descriptionTextField.delegate = self
    }
    
    private func setupHierarchy() {
        addSubview(rowStack)
        
        [isCompletedButton, textStack, goToDetailsButton]
            .forEach { rowStack.addArrangedSubview($0) }
                
        [titleTextField, descriptionTextField, dateLabel]
            .forEach { textStack.addArrangedSubview($0) }
        
        textStack.setCustomSpacing(8, after: descriptionTextField)
    }
    
    private func setupAppearance() {
        isCompletedButton.tintColor = task.isCompleted ? .systemBlue : .gray
        isCompletedButton.setImage(task.isCompleted ? UIImage(systemName: "circle.inset.filled") : UIImage(systemName: "circle"), for: .normal)
                
        titleTextField.font = .preferredFont(forTextStyle: .title3)
        titleTextField.textColor = task.isCompleted ? .secondaryLabel : .label
        titleTextField.text = task.title
        
        descriptionTextField.font = .preferredFont(forTextStyle: .body)
        descriptionTextField.textColor = .secondaryLabel
        descriptionTextField.text = task.descrption
        
        dateLabel.font = .preferredFont(forTextStyle: .footnote)
        dateLabel.textColor = .secondaryLabel
        dateLabel.text = "Created at " + task.createdAt.formatted(date: .abbreviated, time: .omitted)
        
        goToDetailsButton.tintColor = .systemGreen
        goToDetailsButton.setImage(UIImage(systemName: "info.circle"), for: .normal)
    }
    
    private func setupConstraints() {
        [rowStack, isCompletedButton, textStack, titleTextField, descriptionTextField, dateLabel, goToDetailsButton]
            .forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            rowStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            rowStack.topAnchor.constraint(equalTo: topAnchor),
            rowStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            rowStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            isCompletedButton.firstBaselineAnchor.constraint(equalTo: titleTextField.firstBaselineAnchor),
            goToDetailsButton.firstBaselineAnchor.constraint(equalTo: titleTextField.firstBaselineAnchor)
        ])
    }
    
    func sdjfhs() {
        Int.random(in: 0...Int(Int16.max))
    }
    
    @objc private func didTapIsCompletedButton() {
        presenter.didTapIsCompletedButton(forTaskWithId: task.id, isCompleted: !task.isCompleted)
    }
    
    @objc private func didTapDetailsButton() {
        presenter.didTapDetailsButton(forTaskWithId: task.id)
    }
}

extension ToDoCellView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = titleTextField.text, !text.isEmpty else {
            presenter.didDeleteTask(withId: task.id)
            return
        }
        let newTitle = titleTextField.text
        let newDescription = descriptionTextField.text
        presenter.didEditTask(withId: task.id, newTitle: newTitle, newDescription: newDescription)
    }
}

#Preview {
    let cell = ToDoCellView(
        task: .init(
            id: 1,
            title: "Todo title",
            descrption: "Optional very long description, it should be at multiple lines",
            createdAt: .now,
            isCompleted: false),
        presenter: ToDoListPresenter(
            interactor: ToDoListInteractor(),
            router: ToDoListRouter())
    )
    return cell
}
