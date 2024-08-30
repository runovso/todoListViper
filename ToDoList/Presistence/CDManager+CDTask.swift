//
//  CDManager+CDTask.swift
//  ToDoList
//
//  Created by Sergei Runov on 25.08.2024.
//

import Foundation
import CoreData

extension CDManager where T == CDTask {
        
    // MARK: - Methods
    
    func getAll(in context: CDContainer.Context = .backgroundContext) -> [CDTask] {
        do {
            let request = CDTask.fetchRequest()
            let moc = context.moc
            return try moc.fetch(request)
        } catch {
            print("Error while trying to fetch all tasks in \(context): \(error.localizedDescription)")
            return []
        }
    }
    
    @discardableResult
    func update(from dto: TaskDTO, in context: CDContainer.Context = .backgroundContext) -> CDTask {
        if let entity = get(byId: dto.id, in: context) {
            entity.todo = dto.todo
            entity.completed = dto.completed
            save(context)
            return entity
        } else {
            return create(from: dto, in: context)
        }
    }
        
    // MARK: - Private methods
    
    private func get(byId id: Int16, in context: CDContainer.Context = .backgroundContext) -> CDTask? {
        do {
            let moc = context.moc
            let request = CDTask.fetchRequest()
            let predicate = NSPredicate(format: "id == %d", id)
            request.predicate = predicate
            let fetchResult = try moc.fetch(request)
            guard let result = fetchResult.first else { return nil }
            return result
        } catch {
            print("Error while trying to fetch task with id \(id): \(error.localizedDescription)")
            return nil
        }
    }
    
    @discardableResult
    private func create(from dto: TaskDTO, in context: CDContainer.Context = .backgroundContext) -> CDTask {
        let moc = context.moc
        let entity = CDTask(context: moc)
        entity.id = dto.id
        entity.todo = dto.todo
        entity.toDoDescription = nil
        entity.completed = dto.completed
        entity.createdAt = Date()
        save(context)
        return entity
    }
}
