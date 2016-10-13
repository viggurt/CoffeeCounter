//
//  ViewController.swift
//  CoffeeCount
//
//  Created by Viktor on 07/10/16.
//  Copyright © 2016 viggurt. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: Outlets
    @IBOutlet weak var teaButton: UIButton!
    @IBOutlet weak var coffeeButton: UIButton!
    @IBOutlet weak var coffeeCreator: UIButton!
    @IBOutlet weak var coffeeCounter: UILabel!
    @IBOutlet weak var teaCountLabel: UILabel!
    @IBOutlet weak var coffeeTimerLabel: UILabel!
    @IBOutlet weak var teaTimerLabel: UILabel!
    @IBOutlet weak var coffeeCreatorTimer: UILabel!
    
    //MARK: Variables
    var cameraCount = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        /*
         self.teaButton.layer.cornerRadius = self.teaButton.frame.height/2
         self.teaButton.clipsToBounds = true
         self.coffeeButton.layer.cornerRadius = self.teaButton.frame.height/2
         self.coffeeButton.clipsToBounds = true
         self.coffeeCreator.layer.cornerRadius = self.teaButton.frame.height/2
         self.coffeeCreator.clipsToBounds = true
         */

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Functions
    func updateTeaTimer(){
        Tea.sharedInstance.counter += 1
        teaTimerLabel.text = "\(Tea.sharedInstance.counter) seconds"
        
        if Tea.sharedInstance.counter == 60 {
            Tea.sharedInstance.counter = 1
            Tea.sharedInstance.timer.invalidate()
            teaTimerLabel.text = "\(Tea.sharedInstance.counter) min"
            Tea.sharedInstance.timer = Timer.scheduledTimer(timeInterval: 60, target:self, selector: #selector(updateTeaTimer), userInfo: nil, repeats: true)
            
            if Tea.sharedInstance.counter == 60 {
                Tea.sharedInstance.counter = 1
                Tea.sharedInstance.timer.invalidate()
                teaTimerLabel.text = "\(Tea.sharedInstance.counter)h"
                Tea.sharedInstance.timer = Timer.scheduledTimer(timeInterval: 3600, target:self, selector: #selector(updateTeaTimer), userInfo: nil, repeats: true)
            }
        }
    }
    
    func updateCoffeeTimer(){
        Coffee.sharedInstance.counter += 1
        coffeeTimerLabel.text = "\(Coffee.sharedInstance.counter) seconds"
       
        if Coffee.sharedInstance.counter == 60 {
            Coffee.sharedInstance.counter = 1
            Coffee.sharedInstance.timer.invalidate()
            coffeeTimerLabel.text = "\(Coffee.sharedInstance.counter) min"
            Coffee.sharedInstance.timer = Timer.scheduledTimer(timeInterval: 60, target:self, selector: #selector(updateTeaTimer), userInfo: nil, repeats: true)
            
            if Coffee.sharedInstance.counter == 60 {
                Coffee.sharedInstance.counter = 1
                Coffee.sharedInstance.timer.invalidate()
                coffeeTimerLabel.text = "\(Coffee.sharedInstance.counter)h"
                Coffee.sharedInstance.timer = Timer.scheduledTimer(timeInterval: 3600, target:self, selector: #selector(updateCoffeeTimer), userInfo: nil, repeats: true)
            }
        }

    }
    
    func updateCoffeeCreatorTimer(){
        CoffeeCreator.sharedInstance.counter += 1
        coffeeCreatorTimer.text = "\(CoffeeCreator.sharedInstance.counter) seconds"
        
        if CoffeeCreator.sharedInstance.counter == 60 {
            CoffeeCreator.sharedInstance.counter = 1
            CoffeeCreator.sharedInstance.timer.invalidate()
            coffeeCreatorTimer.text = "\(CoffeeCreator.sharedInstance.counter) min"
            CoffeeCreator.sharedInstance.timer = Timer.scheduledTimer(timeInterval: 60, target:self, selector: #selector(updateTeaTimer), userInfo: nil, repeats: true)
            
            if CoffeeCreator.sharedInstance.counter == 60 {
                CoffeeCreator.sharedInstance.counter = 1
                CoffeeCreator.sharedInstance.timer.invalidate()
                coffeeCreatorTimer.text = "\(CoffeeCreator.sharedInstance.counter)h"
                CoffeeCreator.sharedInstance.timer = Timer.scheduledTimer(timeInterval: 3600, target:self, selector: #selector(updateCoffeeCreatorTimer), userInfo: nil, repeats: true)
            }
        }

    }
    
    func updateCameraCountdown(){
        cameraCount = 3
        
        if cameraCount > 0 {
            cameraCount -= 1
            print(cameraCount)
        }
        
        
        
        
    }
    
    //MARK: Actions
    @IBAction func teaButtonPressed(_ sender: AnyObject) {
        Tea.sharedInstance.counter = 0
        Tea.sharedInstance.timer.invalidate()
        teaTimerLabel.text = "\(Tea.sharedInstance.counter) seconds"
        Tea.sharedInstance.timer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: #selector(updateTeaTimer), userInfo: nil, repeats: true)
        
        Tea.sharedInstance.cupCounter += 1
        teaCountLabel.text = "\(Tea.sharedInstance.cupCounter)"
    }
    
    @IBAction func coffeeButtonPressed(_ sender: AnyObject) {
        Coffee.sharedInstance.counter = 0
        Coffee.sharedInstance.timer.invalidate()
        coffeeTimerLabel.text = "\(Coffee.sharedInstance.counter) min"
        Coffee.sharedInstance.timer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: #selector(updateCoffeeTimer), userInfo: nil, repeats: true)
        
        Coffee.sharedInstance.cupCounter += 1
        coffeeCounter.text = "\(Coffee.sharedInstance.cupCounter)"
    }
    
    @IBAction func coffeeCreatorButtonPressed(_ sender: AnyObject) {
        CoffeeCreator.sharedInstance.counter = 0
        CoffeeCreator.sharedInstance.timer.invalidate()
        coffeeCreatorTimer.text = "\(CoffeeCreator.sharedInstance.counter) min"
        CoffeeCreator.sharedInstance.timer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: #selector(updateCoffeeCreatorTimer), userInfo: nil, repeats: true)
        
        //Access camera on press
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            var imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
            var timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCameraCountdown), userInfo: nil, repeats: true)
        }
        
        //Start countdown
        
        //Store picture backend
    }
}

