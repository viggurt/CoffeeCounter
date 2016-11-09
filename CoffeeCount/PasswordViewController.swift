//
//  PasswordViewController.swift
//  CoffeeCount
//
//  Created by Viktor on 2016-11-09.
//  Copyright © 2016 viggurt. All rights reserved.
//

import UIKit

class PasswordViewController: UIViewController {
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    let VC = CreatorTableViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Singleton.sharedInstance.currentPasswordInput = passwordTextField.text!
        
        present(VC, animated: true, completion: { _ in })

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
