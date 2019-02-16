//
//  ViewController.swift
//  ToDoList
//
//  Created by IMCS2 on 2/14/19.
//  Copyright © 2019 IMCS2. All rights reserved.
//

import UIKit

var a: [String] = []

var isRunOnce: Bool = false

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var text: String = ""
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return a.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellToDo", for: indexPath) as UITableViewCell
            cell.textLabel?.text = a[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let completeAction = UIContextualAction(style: .normal, title:  "Mark as Complete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
//            print("OK, marked as Closed")
            success(true)
            c.insert(a[indexPath.row], at: 0)
            a.remove(at: indexPath.row)
            UserDefaults.standard.set(c, forKey: "CompletedList")
            UserDefaults.standard.set(a, forKey:"ToDoArray")
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
            a.remove(at: indexPath.row)
            UserDefaults.standard.set(a, forKey:"ToDoArray")
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
            if UserDefaults.standard.value(forKey: "ToDoArray") != nil{
                a = UserDefaults.standard.value(forKey: "ToDoArray") as! [String]
            }
            if UserDefaults.standard.value(forKey: "CompletedList") != nil{
                c = UserDefaults.standard.value(forKey: "CompletedList") as![String]
            }
            isRunOnce = true
        }
        if text != ""{
            a.insert(text, at: 0)
            UserDefaults.standard.set(a, forKey:"ToDoArray")
        }
    }


}

