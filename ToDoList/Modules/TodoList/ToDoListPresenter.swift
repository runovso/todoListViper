//
//  ToDoListPresenter.swift
//  ToDoList
//
//  Created by Sergei Runov on 26.08.2024.
//

final class ToDoListPresenter {
    
    // MARK: - Properties
    
    weak var view: ToDoListViewInput?
    let interactor: ToDoListInteractorInput
    
    // MARK: - Initialization
    
    init(interactor: ToDoListInteractorInput) {
        self.interactor = interactor
    }
}

extension ToDoListPresenter: ToDoListViewOutput {
    func didTapCompleteButton(forTaskWithId id: Int) {
        
    }
    
    func didTapTitleLabel(forTaskWithId id: Int) {
        
    }
    
    func didTapDescriptionLabel(forTaskWithId id: Int) {
        
    }
    
    func didTapDetailsButton(forTaskWithId id: Int) {
        
    }
}

extension ToDoListPresenter: ToDoListInteractorOutput {
    func didCreateTask(withId id: Int) {
        
    }
    
    func didLoadTask() {
        
    }
    
    func didUpdateTask() {
        
    }
    
    func didDeleteTask(withId id: Int) {
        
    }
    
    func didRecieve(error: any Error) {
        
    }
    
    
}
