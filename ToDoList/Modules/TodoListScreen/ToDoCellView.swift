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
    
    func setupTargetsAndDelegates() {
        isCompletedButton.addTarget(self, action: #selector(didTapIsCompletedButton), for: .touchUpInside)
        goToDetailsButton.addTarget(self, action: #selector(didTapDetailsButton), for: .touchUpInside)
        
        titleTextView.delegate = self
        descriptionTextView.delegate = self
    }
    
    func setupHierarchy() {
        contentView.addSubview(rowStack)
        
        [isCompletedButton, textStack, goToDetailsButton]
            .forEach { rowStack.addArrangedSubview($0) }
                
        [titleTextView, descriptionTextView, dateTextView]
            .forEach { textStack.addArrangedSubview($0) }
    }
    
    func setupAppearance() {
        guard let task else { return }
        
        isCompletedButton.tintColor = task.isCompleted ? .systemBlue : .gray
        isCompletedButton.setImage(task.isCompleted ? UIImage(systemName: "circle.inset.filled") : UIImage(systemName: "circle"), for: .normal)

        [titleTextView, descriptionTextView, dateTextView].forEach {
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
//        descriptionTextView.isHidden = task.descrption == nil ? true : false
        
        dateTextView.font = .preferredFont(forTextStyle: .footnote)
        dateTextView.textColor = .secondaryLabel
        dateTextView.text = "Created at " + task.createdAt.formatted(date: .abbreviated, time: .omitted)
        dateTextView.isEditable = false

        goToDetailsButton.tintColor = .systemGreen
        goToDetailsButton.setImage(UIImage(systemName: "info.circle"), for: .normal)
    }
    
    func setupConstraints() {
        [rowStack, isCompletedButton, textStack, titleTextView, descriptionTextView, dateTextView, goToDetailsButton]
            .forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        titleTextView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        NSLayoutConstraint.activate([
            rowStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            rowStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            rowStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            rowStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            titleTextView.leadingAnchor.constraint(equalTo: textStack.leadingAnchor),
            titleTextView.trailingAnchor.constraint(equalTo: textStack.trailingAnchor),
            
            descriptionTextView.widthAnchor.constraint(equalTo: titleTextView.widthAnchor),
            
            dateTextView.widthAnchor.constraint(equalTo: titleTextView.widthAnchor),
            
            isCompletedButton.widthAnchor.constraint(equalToConstant: isCompletedButton.intrinsicContentSize.width),
            isCompletedButton.firstBaselineAnchor.constraint(equalTo: titleTextView.firstBaselineAnchor),
            
            goToDetailsButton.widthAnchor.constraint(equalToConstant: goToDetailsButton.intrinsicContentSize.width),
            goToDetailsButton.firstBaselineAnchor.constraint(equalTo: titleTextView.firstBaselineAnchor)
        ])        
    }
    
    @objc func didTapIsCompletedButton() {
        guard let task else { return }
        presenter?.didTapIsCompletedButton(forTaskWithId: task.id, isCompleted: !task.isCompleted)
    }
    
    @objc func didTapDetailsButton() {
        guard let task else { return }
        presenter?.didTapDetailsButton(forTaskWithId: task.id)
    }
    
//    func setHeightThatFits(to view: UIView) {
//        let size = CGSize(width: view.frame.width, height: .infinity)
//        let estimatedSize = view.sizeThatFits(size)
//        view.constraints.forEach {
//            if $0.firstAttribute == .height { $0.constant = estimatedSize.height }
//        }
//    }
}

// MARK: - UITextViewDelegate methods

extension ToDoCellView: UITextViewDelegate {
        
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == titleTextView {
//            if descriptionTextView.isHidden == true {
                descriptionTextView.text = "Add note"
                descriptionTextView.isHidden = false
//            }
        }
        
        if textView == descriptionTextView {
            if task?.descrption == nil {
                descriptionTextView.text = ""
            }
        }
        
//        guard textView == titleTextView else { return }
//        if descriptionTextView.isHidden == true {
//            descriptionTextView.text = "Add note"
//            descriptionTextView.isHidden = false
//            
//            if let tableView = superview as? UITableView {
//                tableView.beginUpdates()
//                tableView.endUpdates()
//            }
//        }
    }

    func textViewDidChange(_ textView: UITextView) {
//        setHeightThatFits(to: textView)
//        
//        if let tableView = superview as? UITableView {
//            tableView.beginUpdates()
//            tableView.endUpdates()
//        }
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        guard let task else { return }
        guard let newTitle = titleTextView.text, !newTitle.isEmpty else {
            presenter?.didDeleteTask(withId: task.id)
            return
        }
        
        let newDescription = descriptionTextView.text.isEmpty ? nil : descriptionTextView.text
        presenter?.didEditTask(withId: task.id, newTitle: newTitle, newDescription: newDescription)
        
        if task.descrption == nil {
//            descriptionTextView.isHidden = true
//            descriptionTextView.text = ""
        }
    }
}

#Preview {
    let vc = ToDoListAssembly.build()
    let nc = UINavigationController(rootViewController: vc)
    return nc
}
