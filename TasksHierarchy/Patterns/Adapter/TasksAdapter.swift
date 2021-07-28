//
//  TasksAdapter.swift
//  TasksHierarchy
//
//  Created by Maksim on 28.07.2021.
//

import Foundation

class TasksAdapter {
    
    func tasksToCareConvertToTasksForOneParent(toConvert tasks: [TaskToCare],for parentId: Int) -> [Task] {
        // если в памяти нет Tasks
        if tasks.count == 0 {
            print("TaskToCare Array is empty")
            return []
        }
        // если в памяти есть Tasks
        // если MainVC то ParentTask
        if parentId == 0 {
            var tmpTasksArray:[Task] = []
            tasks.forEach { task in
                if task.parentId == parentId {
                    var childTasksArr: [ParentTask] = []
                    tasks.forEach { tsk in
                        if tsk.parentId == task.taskId {
                            if let newChildTaskToAdd = ParentTask(taskString: tsk.taskString, taskId: tsk.taskId, parentId: tsk.parentId, childsCount: tsk.childsCount) {
                                childTasksArr.append(newChildTaskToAdd)
                            }
                        }
                    }
                    if let newTaskToAdd = ParentTask(taskString: task.taskString, taskId: task.taskId, childTasks: childTasksArr, parentId: task.parentId, childsCount: task.childsCount) {
                        tmpTasksArray.append(newTaskToAdd)
                    }
                }
            }
            return tmpTasksArray
        }
        
        // если остальные то ChildTask

        var tmpTasksArray:[Task] = []
        tasks.forEach { task in
            if task.parentId == parentId {
                var childTasksArr: [ChildTask] = []
                tasks.forEach { tsk in
                    if tsk.parentId == task.taskId {
                        if let newChildTaskToAdd = ChildTask(taskString: tsk.taskString, taskId: tsk.taskId, parentTaskId: tsk.parentId, childsCount: tsk.childsCount) {
                            childTasksArr.append(newChildTaskToAdd)
                        }
                    }
                }
                if let newTaskToAdd = ChildTask(taskString: task.taskString, taskId: task.taskId, childTasks: childTasksArr, parentTaskId: task.parentId, childsCount: task.childsCount) {
                    tmpTasksArray.append(newTaskToAdd)
                }
            }
        }
        return tmpTasksArray
    }

    func tasksConvertToTasksToCare(toConvert tasks: [Task]) -> [TaskToCare] {
        var tmpTaskArray:[TaskToCare] = []
        tasks.forEach { task in
            let taskToAdd = TaskToCare(taskString: task.taskString, taskId: task.taskId, parentId: task.parentId, childsCount: task.childsCount)
            tmpTaskArray.append(taskToAdd)
        }
        
        return tmpTaskArray
    }
    
    func taskConvertToTaskToCare(toConvert task: Task) -> TaskToCare {
        let task = TaskToCare(taskString: task.taskString, taskId: task.taskId, parentId: task.parentId, childsCount: task.childsCount)
        return task
    }
}
