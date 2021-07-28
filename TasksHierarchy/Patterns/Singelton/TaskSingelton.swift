//
//  TaskSingelton.swift
//  TasksHierarchy
//
//  Created by Maksim on 27.07.2021.
//

import Foundation

//MARK: ->Singelton - Id task
class TaskIdsSingelton {
    static let shared = TaskIdsSingelton()
    private let idsCareTaker = CareTakerIds()
    public var savedIds: [IdToCare] {
        didSet {
            print("new id Added in Singleton", savedIds.last)
            idsCareTaker.saveIds(ids: savedIds)
        }
    }
    
    private init() {
        savedIds = idsCareTaker.loadIds() ?? []
    }
    
    public func getId() -> Int {
        guard let lastId = self.savedIds.last else {
            print("Suddenly found that no base Index in id - TaskIdsSingleton")
            savedIds.append(IdToCare(id: 0))
            savedIds.append(IdToCare(id: 1))
            return 1
        }
        let newId = IdToCare(id: (lastId.id + 1))
        self.savedIds.append(newId)
        return newId.id
    }
    
    public func destructId(idToDelete: Int) {
        
        self.removeIdFromArray(id: idToDelete)

    }
    
    private func addIdToArray(id: IdToCare) {
        savedIds.append(id)
    }
    
    private func removeIdFromArray(id: Int) {
        guard let indTmp = savedIds.firstIndex(where: { $0.id == id
        }) else {
            print("Error cannot get index to delete in Singleton")
            return
        }
        savedIds.remove(at: indTmp)
    }
    
}

//MARK: -> Singelton - to save with Memento
class TasksSaveSingelton {
    static let shared = TasksSaveSingelton()
    private let tasksCareTaker = CareTakerTasks()
    
    public var savedTasks: [TaskToCare] {
        didSet {
            tasksCareTaker.saveTasks(tasks: savedTasks)
        }
    }
    
    private init () {
        savedTasks = tasksCareTaker.loadTasks() ?? []
    }
    
    public func addTaskToArray(task: TaskToCare) {
        savedTasks.append(task)
    }
    
    public func removeTaskFromArray(taskId: Int) {
        guard let indTmp = (savedTasks.firstIndex { $0.taskId == taskId }) else {
            print("Error cannot get index to delete in Singleton")
            return
        }
        savedTasks.remove(at: indTmp)
    }
}
