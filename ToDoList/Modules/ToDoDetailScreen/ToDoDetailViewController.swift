//
//  ToDoDetailViewController.swift
//  ToDoList
//
//  Created by Sergei Runov on 30.08.2024.
//

import UIKit

final class ToDoDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    private let task: TaskModel
    
    // MARK: - Lifecycle
    
    init(task: TaskModel) {
        self.task = task
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
    }
    
}
