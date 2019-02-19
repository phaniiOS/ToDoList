//
//  NewTaskViewController.swift
//  ToDoList
//
//  Created by IMCS2 on 2/14/19.
//  Copyright © 2019 IMCS2. All rights reserved.
//

import UIKit

class NewTaskViewController: UIViewController {

    @IBOutlet weak var NewTaskTextFeild: UITextField!
    @IBAction func AddNewTaskButton(_ sender: Any) {
        performSegue(withIdentifier: "NewTask", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ViewController
        vc.text = NewTaskTextFeild.text!
    }
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
