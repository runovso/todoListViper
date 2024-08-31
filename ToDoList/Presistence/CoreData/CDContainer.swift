//
//  CDContainer.swift
//  ToDoList
//
//  Created by Sergei Runov on 25.08.2024.
//

import Foundation
import CoreData

final class CDContainer {
    
     // MARK: - Singleton static property
    
    static let shared = CDContainer()
    
    // MARK: - Properties
    
    let container: NSPersistentContainer
    
    // MARK: - Private properties
    
    private let mainContext: NSManagedObjectContext
    private lazy var backgroundContext: NSManagedObjectContext = {
        return container.newBackgroundContext()
    }()
    
    // MARK: - Enum
    
    enum Context: CaseIterable {
        case mainContext
        case backgroundContext
        
        var moc: NSManagedObjectContext {
            switch self {
            case .mainContext:
                return CDContainer.shared.mainContext
            case .backgroundContext:
                return CDContainer.shared.backgroundContext
            }
        }
    }

    // MARK: - Initialization
    
    private init() {
        let container = NSPersistentContainer(name: "ToDoList")
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Error while initializing persistent container for CoreData, error: \(error.localizedDescription)")
            }
        }
                
        self.container = container
        self.mainContext = container.viewContext
    }
}
