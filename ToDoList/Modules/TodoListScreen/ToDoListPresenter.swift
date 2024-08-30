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
    let router: ToDoListRouterInput
    
    // MARK: - Private properties
    
    private var numberOfTasks: Int?
    
    // MARK: - Initialization
    
    init(interactor: ToDoListInteractorInput, router: ToDoListRouterInput) {
        self.interactor = interactor
        self.router = router
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
    
    func didTapIsCompletedButton(forTaskWithId taskId: Int, isCompleted: Bool) {
        interactor.updateTask(withId: taskId, newTitle: nil, newDescription: nil, isCompleted: isCompleted)
    }
    
    func didEditTask(withId taskId: Int, newTitle: String?, newDescription: String?) {
        interactor.updateTask(withId: taskId, newTitle: newTitle, newDescription: newDescription, isCompleted: nil)
    }
    
    func didTapDetailsButton(forTaskWithId taskId: Int) {
        guard let task = interactor.getTask(withId: taskId),
              let taskModel = createModel(forTask: task) else {
            #warning("Handle error here")
            return
        }
        router.presentDetailScreen(forTask: taskModel)
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

private extension ToDoListPresenter {
    
    func createModel(forTask task: CDTask) -> TaskModel? {
        guard let createdAt = task.createdAt, let title = task.todo else { return nil }
        return .init(id: Int(task.id), title: title, descrption: task.toDoDescription, createdAt: createdAt, isCompleted: task.completed)
    }
}
