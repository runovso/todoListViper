//
//  ToDoListProtocols.swift
//  ToDoList
//
//  Created by Sergei Runov on 26.08.2024.
//

import Foundation

// MARK: - List View protocols

protocol ToDoListViewInput: AnyObject {
    
    // Properties: strong reference to Presenter from View
    var presenter: ToDoListViewOutput { get }
    
    // Methods to tell View to update itself
    func show(tasks: [TaskModel])
}

protocol ToDoListViewOutput: AnyObject {
    
    // Properties: weak reference to View from Presenter
    var view: ToDoListViewInput? { get set }
    var numberOfSections: Int { get }
    var numberOfRowsInSection: Int { get }
    
    // Methods to send Presenter some user actions
    func viewDidLoad()
    func didTapIsCompletedButton(forTaskWithId taskId: Int, isCompleted: Bool)
    func didEditTask(withId taskId: Int, newTitle: String?, newDescription: String?)
    func didDeleteTask(withId taskId: Int)
    func didTapDetailsButton(forTaskWithId taskId: Int)
}

// MARK: - Interactor protocols

protocol ToDoListInteractorInput: AnyObject {
    
    // Properties: weak reference to Presenter from Interactor
    var presenter: ToDoListInteractorOutput? { get set }
    
    // Methods to tell Interactor to do smth
    func createTask(title: String, description: String?)
    func getAllTasks()
    func getTask(withId taskId: Int) -> CDTask?
    func updateTask(withId id: Int, newTitle: String?, newDescription: String?, isCompleted: Bool?)
    func deleteTask(withId id: Int)
}

protocol ToDoListInteractorOutput: AnyObject {
    
    // Properties: strong reference to Interactor from Presenter
    var interactor: ToDoListInteractorInput { get }
    
    // Methods to notify Presenter that Interactor did smth
    func didCreate(task: TaskModel)
    func didLoad(task: TaskModel)
    func didLoad(tasks: [TaskModel])
    func didUpdate(task: TaskModel)
    func didDeleteTask(withId id: Int)
    func didRecieve(error: Error)
}

// MARK: - Presenter protocols

protocol ToDoListPresenterInput: AnyObject {
    
    // Properties
    
    // Methods to
}

protocol ToDoListPresenterOutput: AnyObject {
    
    // Properties
    
    // Methods to
    
}

// MARK: - Router protocol

protocol ToDoListRouterInput: AnyObject {
    
    // Properties
    
    // Methods to navigate to some view
    func presentDetailScreen(forTask task: TaskModel)
}
