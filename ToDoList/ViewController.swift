//
//  ViewController.swift
//  ToDoList
//
//  Created by IMCS2 on 2/14/19.
//  Copyright © 2019 IMCS2. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

var tasks: [String] = []
var isRunOnce: Bool = false

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var text: String = ""
    var ref: DatabaseReference!
    @IBOutlet weak var taskTableViewOutlet: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellToDo", for: indexPath) as UITableViewCell
            cell.textLabel?.text = tasks[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let completeAction = UIContextualAction(style: .normal, title:  "Mark as Complete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
//            print("OK, marked as Closed")
            success(true)
            completed.insert(tasks[indexPath.row], at: 0)
            tasks.remove(at: indexPath.row)
            self.ref = Database.database().reference().child("AllTasks").child("task")
            self.ref.setValue(tasks)
            self.ref = Database.database().reference().child("CompletedTasks").child("task")
            self.ref.setValue(completed)
//            print(c.count)
            tableView.reloadData()
        })
//        closeAction.image = UIImage(named: "tick")
        completeAction.backgroundColor = .orange
        return UISwipeActionsConfiguration(actions: [completeAction])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title:  "Delete Task", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
//            print("Update action ...")
            success(true)
            tasks.remove(at: indexPath.row)
            self.ref = Database.database().reference().child("AllTasks").child("task")
            self.ref.setValue(tasks)
            tableView.reloadData()
        })
//        deleteAction.image = UIImage(named: "hammer")
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if !isRunOnce{
            var i = 0
            ref = Database.database().reference().child("AllTasks").child("task")
            ref!.observeSingleEvent(of: .value){ (snapshot: DataSnapshot) in
                for val in snapshot.children{
                    let snapshotContent = val as? DataSnapshot
                    let task = snapshotContent?.value as? String
//                    print(task!)
                    //                    print(i)
                    tasks.insert(task!, at: i)
                    i += 1
                }
                self.taskTableViewOutlet.reloadData()
//                print(tasks.count)
                i = 0
                self.ref = Database.database().reference().child("CompletedTasks").child("task")
                self.ref!.observeSingleEvent(of: .value){ (snapshot: DataSnapshot) in
                    for val in snapshot.children{
                        let snapshotContent = val as? DataSnapshot
                        let task = snapshotContent?.value as? String
//                        print(task!)
                        //                    print(i)
                        completed.insert(task!, at: i)
                        i += 1
                    }
                }
            }
            isRunOnce = true
        }else{
            if text != ""{
                tasks.insert(text, at: 0)
    //            UserDefaults.standard.set(tasks, forKey:"ToDoArray")
                ref = Database.database().reference().child("AllTasks").child("task")
                self.ref.setValue(tasks)
            }
            if isCompletedChange{
                ref = Database.database().reference().child("CompletedTasks").child("task")
                self.ref.setValue(completed)
                isCompletedChange = false
            }
        }
    }


}
