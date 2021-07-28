//
//  ViewController.swift
//  TasksHierarchy
//
//  Created by Maksim on 27.07.2021.
//

import UIKit
import Foundation

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addBarBtn: UIBarButtonItem!
    
    var tasks: [Task] = []
    var tasksToCare: [TaskToCare] = []
    
    var tasksAdapter = TasksAdapter()
    
    private let viewModelFactory = TaskViewModelFactory()
    private var tasksViewModels: [TaskViewModel] = []
    
    var parentId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        view.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)

        tableView.register(UINib(nibName: TasksCell.nibName, bundle: nil), forCellReuseIdentifier: TasksCell.reuseIdentifierOfCell)
        
//        getTasksFromMemmory()
//        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // TO DO completion
        getTasksFromMemmory()
        
        self.tasksViewModels = viewModelFactory.constructViewModel(from: tasks)
        
        tableView.reloadData()
    }
    
    func getTasksFromMemmory() {
        tasksToCare = TasksSaveSingelton.shared.savedTasks
        tasks = tasksAdapter.tasksToCareConvertToTasksForOneParent(toConvert: tasksToCare, for: parentId)
    }
    
    
    @IBAction func addBarBtnWasPrssd(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let view = storyBoard.instantiateViewController(withIdentifier: AddTaskVC.reuseIdentifierOfVC) as? AddTaskVC else { return }
        view.parentTaskId = self.parentId
        navigationController?.pushViewController(view, animated: true)
    }
}

//MARK: -> Tableview
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TasksCell.reuseIdentifierOfCell) as? TasksCell else {
            return UITableViewCell()
        }
        cell.configureCell(taskViewModel: tasksViewModels[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let infoTask = tasksViewModels[indexPath.row]
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let view = storyBoard.instantiateViewController(withIdentifier: ChildViewController.reuseIdentifierOfVC) as? ChildViewController else { return }
       
        view.parentIdInt = infoTask.taskId
        view.parentTaskString = infoTask.taskString

        navigationController?.pushViewController(view, animated: true)
    }
    
    
}

