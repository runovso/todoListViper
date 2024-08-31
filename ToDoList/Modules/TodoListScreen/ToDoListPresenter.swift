//
//  ToDoListPresenter.swift
//  ToDoList
//
//  Created by Sergei Runov on 26.08.2024.
//

import Foundation

final class ToDoListPresenter {
    
    // MARK: - Properties
    
    weak var view: ToDoListViewInput?
    let interactor: ToDoListInteractorInput
    let router: ToDoListRouterInput
    
    // MARK: - Private properties
    
    private var numberOfTasks: Int?
    
    // MARK: - Initialization
    
    init(interactor: ToDoListInteractorInput, router: ToDoListRouterInput) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - ToDoListViewOutput methods

extension ToDoListPresenter: ToDoListViewOutput {
    var numberOfSections: Int {
        1
    }
    
    var numberOfRowsInSection: Int {
        numberOfTasks ?? 0
    }
    
    func viewDidLoad() {
        interactor.getAllTasks()
    }
    
    func didTapIsCompletedButton(forTaskWithId taskId: Int16, isCompleted: Bool) {
        interactor.updateTask(withId: taskId, newTitle: nil, newDescription: nil, isCompleted: isCompleted)
    }
    
    func didEditTask(withId taskId: Int16, newTitle: String?, newDescription: String?) {
        interactor.updateTask(withId: taskId, newTitle: newTitle, newDescription: newDescription, isCompleted: nil)
    }
    
    func didTapDetailsButton(forTaskWithId taskId: Int16) {
        guard let task = interactor.getTask(withId: taskId),
              let taskModel = createModel(forTask: task) else {
            #warning("Handle error here")
            return
        }
        router.presentDetailScreen(forTask: taskModel)
    }
}

// MARK: - ToDoListInteractorOutput methods

extension ToDoListPresenter: ToDoListInteractorOutput {
    func didCreate(task: CDTask) {
        
    }
    
    func didLoad(task: CDTask) {
        
    }
    
    func didLoad(tasks: [CDTask]) {
        numberOfTasks = tasks.count
        let taskModels: [TaskModel] = tasks.compactMap { createModel(forTask: $0) }
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            view?.show(tasks: taskModels)
        }
    }
    
    func didUpdate(task: CDTask) {
        
    }
    
    func didDeleteTask(withId id: Int16) {
        
    }
    
    func didRecieve(error: any Error) {
        
    }
}

// MARK: - Private utility methods

private extension ToDoListPresenter {
    
    func createModel(forTask task: CDTask) -> TaskModel? {
        guard let createdAt = task.createdAt, let title = task.todo else { return nil }
        return .init(id: task.id, title: title, descrption: task.toDoDescription, createdAt: createdAt, isCompleted: task.completed)
    }
}
