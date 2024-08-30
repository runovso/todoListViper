//
//  ViewController.swift
//  ToDoList
//
//  Created by Sergei Runov on 25.08.2024.
//

import UIKit

final class ToDoListViewController: UIViewController {
    
    // MARK: - Properties
    
    let presenter: ToDoListViewOutput
    
    // MARK: - Subviews
    
    private let toDoList: UITableView = {
        let table = UITableView()
        table.register(ToDoCellView.self, forCellReuseIdentifier: ToDoCellView.reuseIdentifier)
        return table
    }()
        
    // MARK: - Lifecycle
    
    init(presenter: ToDoListViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupUI()
        setupConstraints()
        presenter.viewDidLoad()
    }
    
    // MARK: - Private methods
    
    private func setupHierarchy() {
        view.addSubview(toDoList)
    }
    
    private func setupUI() {
        self.title = "To Do"
        
        view.backgroundColor = .systemGroupedBackground
        
        toDoList.backgroundColor = .secondarySystemGroupedBackground
        toDoList.clipsToBounds = true
        toDoList.layer.cornerRadius = 16
        toDoList.separatorStyle = .singleLine
    }
    
    private func setupConstraints() {
        toDoList.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            toDoList.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            toDoList.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            toDoList.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            toDoList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ToDoListViewController: ToDoListViewInput {
    func show(tasks: [TaskModel]) {
        
    }
}
