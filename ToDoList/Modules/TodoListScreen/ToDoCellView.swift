//
//  ToDoCellView.swift
//  ToDoList
//
//  Created by Sergei Runov on 26.08.2024.
//

import UIKit

final class ToDoCellView: UITableViewCell {
    
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
    
    private let titleTextView = UITextView()
    private let descriptionTextView = UITextView()
    private let dateTextView = UITextView()
    
    private let isCompletedButton = UIButton()
    private let goToDetailsButton = UIButton()
    
    // MARK: - Properties
    
    private var task: TaskModel?
    private var presenter: ToDoListViewOutput?

    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.isUserInteractionEnabled = true
        setupTargetsAndDelegates()
        setupHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func configure(withTask task: TaskModel, presenter: ToDoListViewOutput) {
        self.task = task
        self.presenter = presenter
        setupAppearance()
    }
}

// MARK: - Configuration methods

private extension ToDoCellView {
    
    private func setupTargetsAndDelegates() {
        isCompletedButton.addTarget(self, action: #selector(didTapIsCompletedButton), for: .touchUpInside)
        goToDetailsButton.addTarget(self, action: #selector(didTapDetailsButton), for: .touchUpInside)
        
        titleTextView.delegate = self
        descriptionTextView.delegate = self
    }
    
    private func setupHierarchy() {
        contentView.addSubview(rowStack)
        
        [isCompletedButton, textStack, goToDetailsButton]
            .forEach { rowStack.addArrangedSubview($0) }
                
        [titleTextView, descriptionTextView, dateTextView]
            .forEach { textStack.addArrangedSubview($0) }
        
        textStack.setCustomSpacing(8, after: descriptionTextView)
    }
    
    private func setupAppearance() {
        guard let task else { return }
        
        isCompletedButton.tintColor = task.isCompleted ? .systemBlue : .gray
        isCompletedButton.setImage(task.isCompleted ? UIImage(systemName: "circle.inset.filled") : UIImage(systemName: "circle"), for: .normal)
        
        [titleTextView, descriptionTextView, dateTextView].forEach {
            $0.isEditable = true
            $0.isScrollEnabled = false
            $0.backgroundColor = .clear
            $0.textContainerInset = .zero
            $0.textContainer.lineFragmentPadding = 0
        }
                
        titleTextView.font = .preferredFont(forTextStyle: .title3)
        titleTextView.textColor = task.isCompleted ? .secondaryLabel : .label
        titleTextView.text = task.title
        
        descriptionTextView.font = .preferredFont(forTextStyle: .body)
        descriptionTextView.textColor = .secondaryLabel
        descriptionTextView.text = task.descrption
        
        dateTextView.font = .preferredFont(forTextStyle: .footnote)
        dateTextView.isEditable = false
        dateTextView.textColor = .secondaryLabel
        dateTextView.text = "Created at " + task.createdAt.formatted(date: .abbreviated, time: .omitted)

        goToDetailsButton.tintColor = .systemGreen
        goToDetailsButton.setImage(UIImage(systemName: "info.circle"), for: .normal)
    }
    
    private func setupConstraints() {
        [rowStack, isCompletedButton, textStack, titleTextView, descriptionTextView, dateTextView, goToDetailsButton]
            .forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            rowStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            rowStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            rowStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            rowStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            isCompletedButton.firstBaselineAnchor.constraint(equalTo: titleTextView.firstBaselineAnchor),
            goToDetailsButton.firstBaselineAnchor.constraint(equalTo: titleTextView.firstBaselineAnchor)
        ])
        
        [titleTextView, descriptionTextView].forEach { textViewDidChange($0) }
    }
    
    @objc private func didTapIsCompletedButton() {
        guard let task else { return }
        presenter?.didTapIsCompletedButton(forTaskWithId: task.id, isCompleted: !task.isCompleted)
    }
    
    @objc private func didTapDetailsButton() {
        guard let task else { return }
        presenter?.didTapDetailsButton(forTaskWithId: task.id)
    }
}

// MARK: - UITextViewDelegate methods

extension ToDoCellView: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: textView.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        textView.constraints.forEach {
            if $0.firstAttribute == .height { $0.constant = estimatedSize.height }
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        guard let task else { return }
        guard let text = titleTextView.text, !text.isEmpty else {
            presenter?.didDeleteTask(withId: task.id)
            return
        }
        let newTitle = titleTextView.text
        let newDescription = descriptionTextView.text
        presenter?.didEditTask(withId: task.id, newTitle: newTitle, newDescription: newDescription)
    }
}

#Preview {
    let cell = ToDoCellView()
    cell.configure(
        withTask: .init(
            id: 1,
            title: "Title",
            descrption: "Optional description",
            createdAt: .now,
            isCompleted: false),
        presenter: ToDoListPresenter(
            interactor: ToDoListInteractor(
                taskManager: CDManager<CDTask>(),
                taskService: TaskService()),
            router: ToDoListRouter()
        )
    )
    return cell
}
