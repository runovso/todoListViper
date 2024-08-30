//
//  ToDoListInteractor.swift
//  ToDoList
//
//  Created by Sergei Runov on 26.08.2024.
//

final class ToDoListInteractor {
    
    // MARK: - Properties
    
    weak var presenter: ToDoListInteractorOutput?
    
}

extension ToDoListInteractor: ToDoListInteractorInput {
    
    func createTask(title: String, description: String?) {
        
    }
    
    func getAllTasks() {
        presenter?.didLoad(tasks: [
            .init(id: 1, title: "First Task", descrption: "Optional description for task 1", createdAt: .now, isCompleted: false),
            .init(id: 2, title: "Second Task", descrption: nil, createdAt: .now, isCompleted: true),
            .init(id: 3, title: "Third Task", descrption: "Optional description for task 3", createdAt: .now, isCompleted: false),
            .init(id: 4, title: "Fourth Task", descrption: "Optional description for task 4", createdAt: .now, isCompleted: true),
            .init(id: 5, title: "Fifth Task", descrption: nil, createdAt: .now, isCompleted: false),
        ])
    }
    
    func getTask(withId taskId: Int) -> CDTask? {
        
        return nil
    }
    
    func updateTask(withId id: Int, newTitle: String?, newDescription: String?, isCompleted: Bool?) {
        
    }
    
    func deleteTask(withId id: Int) {
        
    }
}
