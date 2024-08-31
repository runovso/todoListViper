//
//  UDManager.swift
//  ToDoList
//
//  Created by Sergei Runov on 31.08.2024.
//

import Foundation

final class UDManager<T> {
    
    // MARK: - Private properties
    
    private let storage = UserDefaults.standard
    private let key: String
    
    // MARK: - Initialization
    
    init(key: String) {
        self.key = key
    }
    
    // MARK: - Methods
    
    func get() -> T? {
        storage.value(forKey: key) as? T
    }
    
    func set(value: T?) {
        guard let value else {
            storage.removeObject(forKey: key)
            return
        }
        storage.setValue(value, forKey: key)
    }
}
