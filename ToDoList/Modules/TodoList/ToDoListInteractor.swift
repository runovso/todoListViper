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
        
    }
    
    func updateTask(withId id: Int, newTitle: String?, newDescription: String?, isCompleted: Bool?) {
        
    }
    
    func deleteTask(withId id: Int) {
        
    }
}
