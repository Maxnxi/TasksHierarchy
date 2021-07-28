//
//  TaskViewModel.swift
//  TasksHierarchy
//
//  Created by Maksim on 27.07.2021.
//

import Foundation



struct TaskViewModel {
    
    var taskId: Int
    var taskString: String
    var childTasksCount: Int
    var parentId: Int
    
//    init(taskString: String, childTasksCount: Int) {
//        self.taskString = taskString
//        self.childTasksCount = childTasksCount
//    }
}

final class TaskViewModelFactory {
    func constructViewModel(from tasks: [Task]) -> [TaskViewModel] {
        return tasks.compactMap(self.doViewModel)
    }
    
    private func doViewModel(from task: Task) -> TaskViewModel {
        
        return TaskViewModel(taskId: task.taskId, taskString: task.taskString, childTasksCount: task.childsCount, parentId: task.parentId)
    }
}
