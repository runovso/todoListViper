//
//  UDUserStorage.swift
//  ToDoList
//
//  Created by Sergei Runov on 31.08.2024.
//

enum UDUserStorage<T>: String {
    
    // MARK: - Cases
    
    case isInitialTaskFetchingDone
    
    // MARK: - Private properties
    
    private var manager: UDManager<T> {
        UDManager(key: rawValue)
    }
    
    // MARK: - Methods
    
    func get() -> T? {
        manager.get()
    }
    
    func set(value: T?) {
        manager.set(value: value)
    }
}
