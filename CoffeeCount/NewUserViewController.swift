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
    var passwordFromField : String!
    var vc = CreatorTableViewController()

    @IBOutlet weak var errrorMessageLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    var existsState = false
    var databaseRef = FIRDatabase.database().reference()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nameTextField.delegate = self
        passwordTextField.delegate = self

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
                                          "password" : passwordFromField as AnyObject,
                                          "point" : 0 as AnyObject]
        
        
        
        
        databaseRef.child("Employees").childByAutoId().setValue(post)
        
    }
    

    @IBAction func doneButtonPressed(_ sender: AnyObject) {
        
        let text = nameTextField.text
        let passwordText = passwordTextField.text
        
        if (text?.characters.count)! >= 2 && (passwordText?.characters.count)! >= 2 {//Checking if the input field is not empty
            
            
            if Singleton.sharedInstance.posts.contains(where: { (emp1) in
                emp1.name == text
            }) {
                    print("found")
                    
                    self.errrorMessageLabel.isHidden = false
                    self.errrorMessageLabel.text = "That name already exist. Please choose another one!"
                }
                else{
                    
                    self.nameFromField = self.nameTextField.text
                    self.passwordFromField = self.passwordTextField.text
                    self.post()
                    self.navigationController?.popViewController(animated: true)
                }
                
            
        }else{
            errrorMessageLabel.isHidden = false
        }
        
    }
}
