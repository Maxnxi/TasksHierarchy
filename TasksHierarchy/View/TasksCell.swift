//
//  TasksCell.swift
//  TasksHierarchy
//
//  Created by Maksim on 27.07.2021.
//

import UIKit

class TasksCell: UITableViewCell {

    static var nibName: String = "TasksCell"
    static var reuseIdentifierOfCell: String = "tasksCell"
    
    @IBOutlet weak var taskLbl: UILabel!
    @IBOutlet weak var underTasksCountLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        
    }
    
    func configureCell(taskViewModel: TaskViewModel) {
        self.taskLbl.text = taskViewModel.taskString
        self.underTasksCountLbl.text = "\(taskViewModel.childTasksCount)"
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
