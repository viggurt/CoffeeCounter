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
import TextFieldEffects

class NewUserViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var errorMessageLabel: UILabel!
    var nameFromField: String!
    var passwordFromField : String!
    var vc = CreatorTableViewController()
    
    var masterPassword = "admin"

    var existsState = false
    var databaseRef = FIRDatabase.database().reference()
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
  
    
    func post(){
        
        let post : [String: AnyObject] = ["name" : nameFromField as AnyObject,
                                          "password" : masterPassword as AnyObject,
                                          "point" : 0 as AnyObject]
        
        
        
        
        databaseRef.child("Employees").childByAutoId().setValue(post)
        
    }
    

    @IBAction func doneButtonPressed(_ sender: AnyObject) {
        
        let text = nameTextField.text
        
        if (text?.characters.count)! >= 2 {//Checking if the input field is not empty
            
            
            if Singleton.sharedInstance.posts.contains(where: { (emp1) in
                let name = emp1.name
                let compareStrings = name?.caseInsensitiveCompare(text!) == .orderedSame
                
                return compareStrings
                
            }) {
                    print("found")
                    
                    self.errorMessageLabel.isHidden = false
                    self.errorMessageLabel.text = "That name already exist. Please choose another one!"
                }
                else{
                    
                    self.nameFromField = self.nameTextField.text
                    self.post()
                    self.navigationController?.popViewController(animated: true)
                }
                
            
        }else{
            errorMessageLabel.isHidden = false
        }
        
    }
}
