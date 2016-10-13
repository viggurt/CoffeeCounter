//
//  ViewController.swift
//  CoffeeCount
//
//  Created by Viktor on 07/10/16.
//  Copyright © 2016 viggurt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
        
    @IBOutlet weak var teaButton: UIButton!
    @IBOutlet weak var coffeeButton: UIButton!
    @IBOutlet weak var coffeeCreator: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        teaButton.layer.cornerRadius = self.teaButton.frame.height/2
        teaButton.clipsToBounds = true
        
        coffeeButton.layer.cornerRadius = self.teaButton.frame.height/2
        coffeeButton.clipsToBounds = true
        coffeeCreator.layer.cornerRadius = self.teaButton.frame.height/2
        coffeeCreator.clipsToBounds = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

