//
//  ChildViewController.swift
//  TasksHierarchy
//
//  Created by Maksim on 27.07.2021.
//

import UIKit

class ChildViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var parentIdLbl: UILabel!
    
    
    static let reuseIdentifierOfVC = "childViewController"
    static let nibName = "ChildViewController"
    
    var tasks: [Task] = []
    var tasksToCare: [TaskToCare] = []
    
    var tasksAdapter = TasksAdapter()
    
    private let viewModelFactory = TaskViewModelFactory()
    private var tasksViewModels: [TaskViewModel] = []
    
    var parentIdInt: Int = 0 {
        didSet {
            print("Setted parentId in ChildVC - ", parentIdInt)
        }
    }
    var parentTaskString: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.taskLabel.text = "Task is - \(parentTaskString)"
        self.parentIdLbl.text = "Task id: \(parentIdInt)"
        tableView.delegate = self
        tableView.dataSource = self
        
        view.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        
        tableView.register(UINib(nibName: TasksCell.nibName, bundle: nil), forCellReuseIdentifier: TasksCell.reuseIdentifierOfCell)
        
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBtnWasTapped(sender:))), animated: true)
        
// TO DO
//        let addButton = UIBarButtonItem(image: UIImage(named: "imagename"), style: .plain, target: self, action: Selector("action"))
//        self.navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func addBtnWasTapped(sender: UIBarButtonItem) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let view = storyBoard.instantiateViewController(withIdentifier: AddTaskVC.reuseIdentifierOfVC) as? AddTaskVC else { return }
        view.parentTaskId = self.parentIdInt
        navigationController?.pushViewController(view, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // TO DO completion
        getTasksFromMemmory()
        
        self.tasksViewModels = viewModelFactory.constructViewModel(from: tasks)
        
        tableView.reloadData()
    }
    
    func getTasksFromMemmory() {
        tasksToCare = TasksSaveSingelton.shared.savedTasks
//        guard let prntId = parentId else {
//            print("Error while getting parentId in ChildVC")
//            return
//        }
        tasks = tasksAdapter.tasksToCareConvertToTasksForOneParent(toConvert: tasksToCare, for: parentIdInt)
    }
    
//    func configureView(taskId: Int, taskString: String){
//        self.parentIdLbl.text = "\(taskId)"
//        self.parentId = taskId
//        self.taskLabel.text = taskString
//    }
}

extension ChildViewController: UITableViewDelegate, UITableViewDataSource {
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


    

