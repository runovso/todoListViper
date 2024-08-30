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
    func fetchUserTasks(completion: @escaping (_ data: TaskAPIResponseDTO?, _ error: Error?) -> Void)
}

final class TaskService: TaskServiceType {
    
    let api = "https://dummyjson.com/todos/"
    let userId = 1
    
    func fetchUserTasks(completion: @escaping (_ data: TaskAPIResponseDTO?, _ error: Error?) -> Void) {
        let urlString = api + "user/" + "\(userId)"
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                completion(nil, error)
            }
            guard let response = response as? HTTPURLResponse else {
                completion(nil, TaskServiceError.badResponse)
                return
            }
            guard (0...100).contains(response.statusCode % 200) else {
                completion(nil, TaskServiceError.badStatusCode(response.statusCode))
                return
            }
            guard let data else {
                completion(nil, TaskServiceError.noDataInResponse)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(TaskAPIResponseDTO.self, from: data)
                completion(decodedData, nil)
            } catch {
                print("Error while trying to decode tasks: \(error)")
                return
            }
        }
        task.resume()
    }
}
