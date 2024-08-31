//
//  ToDoListInteractor.swift
//  ToDoList
//
//  Created by Sergei Runov on 26.08.2024.
//

import Foundation

final class ToDoListInteractor {
    
    // MARK: - Properties
    
    weak var presenter: ToDoListInteractorOutput?
    private let taskManager: CDManager<CDTask>
    private let taskService: TaskServiceType
    private let isInitialTaskFetchingDone = UDUserStorage<Bool>.isInitialTaskFetchingDone.get()
    
    // MARK: - Initialization
    
    init(taskManager: CDManager<CDTask>, taskService: TaskServiceType) {
        self.taskManager = taskManager
        self.taskService = taskService
    }
    
}

// MARK: - ToDoListInteractorInput methods

extension ToDoListInteractor: ToDoListInteractorInput {
    
    func createTask(title: String, description: String?) {
        
    }
    
    func getAllTasks() {
        /// Check if initial task fetching done
        ///     If true:
        ///         get all tasks from CoreData
        ///     If false:
        ///         fetch all tasks from API
        ///             If succeed:
        ///                 + save fetched tasks to CoreData
        ///                 + set isInitialTaskFetchingDone to true
        ///                 + get all tasks from CoreData
        ///             If not:
        ///                   show error notification
        ///                 + get all tasks from CoreData
        ///                 + show table with fetched tasks or empty one
        
        guard let isInitialTaskFetchingDone, isInitialTaskFetchingDone else {
            let queue = DispatchQueue.global(qos: .userInitiated)
            queue.async { [weak self] in
                guard let self else { return }
                self.taskService.fetchUserTasks { result in
                    switch result {
                    case .success(let data):
                        data.todos.forEach {
                            self.taskManager.update(from: $0)
                        }
                        UDUserStorage<Bool>.isInitialTaskFetchingDone.set(value: true)
                    case .failure(let error):
                        #warning("Handle error here")
                        print("Error while trying to perform initial tasks fetch: \(error)")
                    }
                    let tasks = self.taskManager.getAll()
                    self.presenter?.didLoad(tasks: tasks)
                }
            }
            return
        }
        let tasks = self.taskManager.getAll()
        self.presenter?.didLoad(tasks: tasks)
    }
    
    func getTask(withId taskId: Int16) -> CDTask? {
        return taskManager.get(byId: taskId)
    }
    
    func updateTask(withId id: Int16, newTitle: String?, newDescription: String?, isCompleted: Bool?) {
        
    }
    
    func deleteTask(withId id: Int16) {
        
    }
}
