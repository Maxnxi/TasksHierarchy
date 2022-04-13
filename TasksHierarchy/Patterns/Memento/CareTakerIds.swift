//
//  CareTakerIds.swift
//  TasksHierarchy
//
//  Created by Maksim on 28.07.2021.
//

import Foundation

struct IdToCare: Codable {
    var id: Int
}

class CareTakerIds {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private let key = "key"
    
    func saveIds(ids: [IdToCare]) {
        do {
            let data = try encoder.encode(ids)
            UserDefaults.standard.setValue(data, forKey: key)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadIds() -> [IdToCare]? {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return nil
        }
        
        do {
            return try decoder.decode([IdToCare].self, from: data)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
