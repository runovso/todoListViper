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
    
    // MARK: - Private properties
    
    private var numberOfTasks: Int?
    
    // MARK: - Initialization
    
    init(interactor: ToDoListInteractorInput) {
        self.interactor = interactor
    }
}

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
    func didCreate(task: TaskModel) {
        
    }
    
    func didLoad(task: TaskModel) {
        
    }
    
    func didLoad(tasks: [TaskModel]) {
        numberOfTasks = tasks.count
    }
    
    func didUpdate(task: TaskModel) {
        
    }
    
    func didDeleteTask(withId id: Int) {
        
    }
    
    func didRecieve(error: any Error) {
        
    }
}
