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

class NewUserViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    var nameFromField: String!
    var vc = CreatorTableViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameTextField.delegate = self

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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = nameTextField.text
        if !(text?.isEmpty)!{//Checking if the input field is not empty
            doneButton.isEnabled = true //Enabling the button
        } else {
            doneButton.isEnabled = false //Disabling the button
        }
        return true
    }
    
    func post(){
        
        let post : [String: AnyObject] = ["name" : nameFromField as AnyObject,
                                          "point" : 0 as AnyObject]
        
        
        let databaseRef = FIRDatabase.database().reference()
        
        databaseRef.child("Employees").childByAutoId().setValue(post)
        
    }
    

    @IBAction func doneButtonPressed(_ sender: AnyObject) {
        nameFromField = nameTextField.text
          post()
        navigationController?.popViewController(animated: true)
    }
}
