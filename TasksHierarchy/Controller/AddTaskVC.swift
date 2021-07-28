//
//  AddTaskVC.swift
//  TasksHierarchy
//
//  Created by Maksim on 28.07.2021.
//

import UIKit

class AddTaskVC: UIViewController {

    @IBOutlet weak var addNewTaskTxtField: UITextField!
    @IBOutlet weak var addNewTaskBtn: UIButton!
    
    static let reuseIdentifierOfVC = "addTaskVC"
    
    var parentTaskId: Int?
    var tasksAdapter = TasksAdapter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
//    func configureView(parentId: Int) {
//        self.parentTaskId = parentId
//    }


    @IBAction func addNewTaskBtnWasPrssd(_ sender: Any) {
        
        guard let taskText = addNewTaskTxtField.text,
              taskText != "" else { return }
        guard let parentId = parentTaskId else {
            print("Error with getting parent id in AddTaskVC")
            return
        }
            
        let newTask = ChildTask(taskString: taskText, parentTask: parentId)
        let convertedTask = tasksAdapter.taskConvertToTaskToCare(toConvert: newTask)
        TasksSaveSingelton.shared.addTaskToArray(task: convertedTask)
        print("New Task added, time to leave this VC")
        
        navigationController?.popViewController(animated: true)
        
    }
}
