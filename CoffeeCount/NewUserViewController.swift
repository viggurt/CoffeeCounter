//
//  NewUserViewController.swift
//  CoffeeCount
//
//  Created by Viktor on 2016-11-07.
//  Copyright © 2016 viggurt. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class NewUserViewController: UIViewController {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    var nameFromField: String!
    var vc = CreatorTableViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func post(){
        
        let post : [String: AnyObject] = ["name" : nameFromField as AnyObject]
        
        let databaseRef = FIRDatabase.database().reference()
        
        databaseRef.child("Employees").childByAutoId().setValue(post)
        
    }
    

    @IBAction func doneButtonPressed(_ sender: AnyObject) {
        nameFromField = nameTextField.text
          post()
        //navigationController?.popToViewController(vc, animated: true)
    }
}
