//
//  PasswordViewController.swift
//  CoffeeCount
//
//  Created by Viktor on 2016-11-10.
//  Copyright © 2016 viggurt. All rights reserved.
//

import UIKit
import TextFieldEffects

class PasswordViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var doneButton: UIButton!

    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //passwordTextField.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func doneButtonPressed(_ sender: AnyObject) {
        if passwordTextField.text == Singleton.sharedInstance.posts[0].password{
            Singleton.sharedInstance.currentPasswordInput = passwordTextField.text!
            self.performSegue(withIdentifier: "unwindToMenu", sender: self)
        }else{
            errorMessageLabel.isHidden = false
        }
    }


}
