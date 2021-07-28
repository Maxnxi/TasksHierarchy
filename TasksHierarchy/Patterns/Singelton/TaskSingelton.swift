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
    public var id = [0]
    
    private init() {}
    
    public func getId() -> Int {
        guard let lastId = id.last else {
            print("Suddenly found that no base Index in id - TaskIdsSingleton")
            id.append(0)
            id.append(1)
            return 1
        }
        let newId = lastId + 1
        id.append(newId)
        return newId
    }
    
    public func destructId(idToDelete: Int) {
        guard let indexOfDeleting = id.firstIndex(of: idToDelete) else {
            print("Error with deleting in TaskSingelton")
            return
        }
        id.remove(at: indexOfDeleting)
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
