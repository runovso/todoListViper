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
    
    func get(byId id: Int16, in context: CDContainer.Context = .backgroundContext) -> CDTask? {
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
    
    @discardableResult
    func update(from model: TaskModel, in context: CDContainer.Context = .backgroundContext) -> CDTask {
        if let entity = get(byId: model.id, in: context) {
            entity.todo = model.title
            entity.toDoDescription = model.descrption
            entity.completed = model.isCompleted
            save(context)
            return entity
        } else {
            return create(from: model, in: context)
        }
    }
    
    @discardableResult
    func update(byId id: Int16, newTitle: String?, newDescription: String?, newCompletionStatus: Bool?, in context: CDContainer.Context = .backgroundContext) -> CDTask? {
        if let entity = get(byId: id) {
            if let newTitle {
                entity.todo = newTitle
            }
            if let newDescription {
                entity.toDoDescription = newDescription
            }
            if let newCompletionStatus {
                entity.completed = newCompletionStatus
            }
            save(context)
            return entity
        } else {
            return nil
        }
    }
        
    // MARK: - Private methods
        
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
    
    @discardableResult
    private func create(from model: TaskModel, in context: CDContainer.Context = .backgroundContext) -> CDTask {
        let moc = context.moc
        let entity = CDTask(context: moc)
        entity.id = model.id
        entity.todo = model.title
        entity.toDoDescription = model.descrption
        entity.completed = model.isCompleted
        entity.createdAt = Date()
        save(context)
        return entity
    }
}
