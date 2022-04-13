//
//  Task.swift
//  TasksHierarchy
//
//  Created by Maksim on 27.07.2021.
//

import Foundation

struct TaskToCare: Codable {
    
    var taskString: String
    var taskId: Int
    var parentId: Int
    var childsCount: Int
}

protocol Task {
    
    var taskString: String { get }
    var childTasks: [Task] { get }
    
    var taskId: Int { get }
    var parentId: Int { get }
    
    var childsCount: Int { get }
    
    func removeTask()
    
    func addChildTask(task: Task)
    //func removeChildTask(task: Task)
    
}


class ParentTask: Task {
    
    var taskString: String
    var childTasks: [Task] = []
    var taskId: Int
    var parentId: Int = 0
    var childsCount: Int = 0
    
    init(taskString: String) {
        self.taskString = taskString
        self.taskId = TaskIdsSingelton.shared.getId()
    }
    
    // Инициализация с детьми
    init?(taskString: String, taskId: Int, childTasks: [Task], parentId: Int, childsCount: Int) {
        self.taskString = taskString
        self.taskId = taskId
        self.childTasks = childTasks
        self.parentId = parentId
        self.childsCount = childsCount
    }
    
    // Инициализация без детей
    init?(taskString: String, taskId: Int, parentId: Int, childsCount: Int) {
        self.taskString = taskString
        self.taskId = taskId
        self.parentId = parentId
        self.childsCount = childsCount
    }

    
    func removeTask() {
        print("deleting task", taskId)
        TaskIdsSingelton.shared.destructId(idToDelete: taskId)
        TasksSaveSingelton.shared.removeTaskFromArray(taskId: taskId)
        childTasks.forEach { $0.removeTask() }
        // to do to check deletion done
    }
    
    func addChildTask(task: Task) {
        childTasks.append(task)
    }
    
//    func removeChildTask(task: Task) {
//        for i in 0..<childTasks.count {
//            if childTasks[i].taskString == task.taskString {
//                childTasks.remove(at: i)
//            }
//        }
//    }
}

class ChildTask: Task {

    var taskString: String
    var childTasks: [Task] = []
    var taskId: Int
    var parentId: Int
    var childsCount: Int = 0
    
    init(taskString: String, parentTask: Int) {
        self.taskString = taskString
        self.taskId = TaskIdsSingelton.shared.getId()
        self.parentId =  parentTask
    }
    
    init?(taskString: String, taskId: Int, childTasks: [Task], parentTaskId: Int, childsCount: Int) {
        self.taskString = taskString
        self.taskId = taskId
        self.childTasks = childTasks
        self.parentId = parentTaskId
        self.childsCount = childsCount
    }
    
    init?(taskString: String, taskId: Int, parentTaskId: Int, childsCount: Int) {
        self.taskString = taskString
        self.taskId = taskId
        self.parentId = parentTaskId
        self.childsCount = childsCount
    }
    
    func removeTask() {
        print("deleting task", taskId)
        TaskIdsSingelton.shared.destructId(idToDelete: taskId)
        TasksSaveSingelton.shared.removeTaskFromArray(taskId: taskId)
        childTasks.forEach { $0.removeTask() }
        // to do to check deletion done
    }
    
    func addChildTask(task: Task) {
        childTasks.append(task)
    }
    
//    func removeChildTask(task: Task) {
//
//    }
    
    
}
