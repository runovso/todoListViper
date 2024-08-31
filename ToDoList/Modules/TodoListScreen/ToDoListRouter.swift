//
//  ToDoListRouter.swift
//  ToDoList
//
//  Created by Sergei Runov on 26.08.2024.
//

import UIKit

final class ToDoListRouter {
    var vc: UIViewController?
}

extension ToDoListRouter: ToDoListRouterInput {
    func presentDetailScreen(forTask task: TaskModel) {
        let newVc = ToDoDetailViewController(task: task)
        if let vc, let nc = vc.navigationController {
            nc.pushViewController(newVc, animated: true)
        }
    }
}
