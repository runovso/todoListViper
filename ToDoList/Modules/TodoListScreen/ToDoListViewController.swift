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
    
    // MARK: - Private properties
    
    private var tasks: [TaskModel] = []
    
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
        presenter.viewDidLoad()
        setupHierarchy()
        setupDelegates()
        setupAppearance()
        setupConstraints()
    }
    
    // MARK: - Private methods
    
    private func setupHierarchy() {
        view.addSubview(toDoList)
    }
    
    private func setupDelegates() {
        toDoList.delegate = self
        toDoList.dataSource = self
    }
    
    private func setupAppearance() {
        view.backgroundColor = .systemBackground
        title = "To Do List"
        navigationController?.navigationBar.prefersLargeTitles = true
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
        self.tasks = tasks
        toDoList.reloadData()
    }
}

extension ToDoListViewController: UITableViewDelegate {
    
}

extension ToDoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = toDoList.dequeueReusableCell(withIdentifier: ToDoCellView.reuseIdentifier, for: indexPath) as? ToDoCellView, !tasks.isEmpty else {
            return UITableViewCell()
        }
        cell.configure(withTask: tasks[indexPath.row], presenter: presenter)
        return cell
    }
}

#Preview {
    let vc = ToDoListAssembly.build()
    return vc
}
