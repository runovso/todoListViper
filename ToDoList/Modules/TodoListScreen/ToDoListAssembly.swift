//
//  ToDoListAssembly.swift
//  ToDoList
//
//  Created by Sergei Runov on 26.08.2024.
//

final class ToDoListAssembly {
    
    // MARK: - Methods
    
    static func build() -> ToDoListViewController {
        let router = ToDoListRouter()
        let interactor = ToDoListInteractor()
        let presenter = ToDoListPresenter(interactor: interactor, router: router)
        let view = ToDoListViewController(presenter: presenter)
        
        router.vc = view
        presenter.view = view
        interactor.presenter = presenter

        return view
    }
}
