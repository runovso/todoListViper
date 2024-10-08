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
        
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 44
        
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
    
    // MARK: ToDoListViewInput methods
    
    func show(tasks: [TaskModel]) {
        self.tasks = tasks
        toDoList.reloadData()
    }
    
    func show(updatedTask: TaskModel) {
        DispatchQueue.main.async {
            #warning("check for leaks")
            guard let index = self.tasks.firstIndex(where: { $0.id == updatedTask.id }) else { return }
            let indexPath = IndexPath(row: index, section: 0)
            self.tasks[index] = updatedTask
            self.toDoList.reloadRows(at: [indexPath], with: .none)
        }
    }
}

// MARK: - UITableViewDelegate methods

extension ToDoListViewController: UITableViewDelegate {
}

// MARK: - UITableViewDataSource methods

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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}

#Preview {
    let vc = ToDoListAssembly.build()
    let nc = UINavigationController(rootViewController: vc)
    return nc
}
