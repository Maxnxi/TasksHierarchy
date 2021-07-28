//
//  CareTakerTasks.swift
//  TasksHierarchy
//
//  Created by Maksim on 27.07.2021.
//

import Foundation

class CareTakerTasks {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private let key = "key"
    
    func saveTasks(tasks: [TaskToCare]) {
        do {
            let data = try encoder.encode(tasks)
            UserDefaults.standard.setValue(data, forKey: key)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadTasks() -> [TaskToCare]? {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return nil
        }
        
        do {
            return try decoder.decode([TaskToCare].self, from: data)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
