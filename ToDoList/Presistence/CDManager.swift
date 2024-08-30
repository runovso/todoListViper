//
//  CDManager.swift
//  ToDoList
//
//  Created by Sergei Runov on 25.08.2024.
//

import Foundation
import CoreData

class CDManager<T: Identifiable> {
    
    // MARK: - Private properties
    
    private let container = CDContainer.shared.container
        
    // MARK: - Initialization
    
    init() {

    }
    
    // MARK: - Computed properties
    
    var entityName: String {
        String(describing: self)
    }
    
    // MARK: - Core Data Saving support

    func save(_ context: CDContainer.Context) {
        let moc = context.moc
        if moc.hasChanges {
            do {
                try moc.save()
            } catch {
                print("Error while trying to save CoreData context, error: \(error.localizedDescription)")
            }
        }
    }
}
