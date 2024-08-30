//
//  TaskDTO.swift
//  ToDoList
//
//  Created by Sergei Runov on 25.08.2024.
//

import Foundation

struct TaskDTO: Identifiable, Codable {
    let id: Int16
    let todo: String
    let completed: Bool
}
