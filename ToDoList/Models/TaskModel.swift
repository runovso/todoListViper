//
//  TaskModel.swift
//  ToDoList
//
//  Created by Sergei Runov on 30.08.2024.
//

import Foundation

struct TaskModel: Identifiable {
    let id: Int16
    let title: String
    let descrption: String?
    let createdAt: Date
    let isCompleted: Bool
}
