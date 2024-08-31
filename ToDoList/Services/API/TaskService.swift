//
//  TaskService.swift
//  ToDoList
//
//  Created by Sergei Runov on 25.08.2024.
//

import Foundation

enum TaskServiceError: Error {
    case badUrl(url: String)
    case badResponse
    case badStatusCode(_ code: Int)
    case noDataInResponse
    case serverError(error: String)
}

protocol TaskServiceType {
    func fetchUserTasks(completion: @escaping (Result<TaskAPIResponseDTO, Error>) -> Void)
}

final class TaskService: TaskServiceType {
    
    let api = "https://dummyjson.com/todos/"
    let userId = 1
    
    func fetchUserTasks(completion: @escaping (Result<TaskAPIResponseDTO, Error>) -> Void) {
        let urlString = api + "user/" + "\(userId)"
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                completion(.failure(error))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(TaskServiceError.badResponse))
                return
            }
            guard (0...100).contains(response.statusCode % 200) else {
                completion(.failure(TaskServiceError.badStatusCode(response.statusCode)))
                return
            }
            guard let data else {
                completion(.failure(TaskServiceError.noDataInResponse))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(TaskAPIResponseDTO.self, from: data)
                completion(.success(decodedData))
            } catch {
                print("Error while trying to decode tasks: \(error)")
                return
            }
        }
        task.resume()
    }
}
