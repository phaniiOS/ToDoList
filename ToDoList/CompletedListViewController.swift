//
//  CompletedListViewController.swift
//  ToDoList
//
//  Created by IMCS2 on 2/14/19.
//  Copyright © 2019 IMCS2. All rights reserved.
//

import UIKit

class CompletedListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//    var completedList: [String] = completed
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return completed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "CellCompleted", for: indexPath) as UITableViewCell
        cell.textLabel?.text = completed[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title:  "Delete Task", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            //            print("Update action ...")
            success(true)
            isCompletedChange = true
            completed.remove(at: indexPath.row)
            tableView.reloadData()
        })
        //        deleteAction.image = UIImage(named: "hammer")
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
//    var completedTask: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
