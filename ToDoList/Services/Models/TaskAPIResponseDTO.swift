//
//  TaskAPIResponseDTO.swift
//  ToDoList
//
//  Created by Sergei Runov on 25.08.2024.
//

import Foundation

struct TaskAPIResponseDTO: Decodable {
    let todos: [TaskDTO]
    let total, skip, limit: Int
}
