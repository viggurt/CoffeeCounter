//
//  ViewController.swift
//  CoffeeCount
//
//  Created by Viktor on 07/10/16.
//  Copyright © 2016 viggurt. All rights reserved.
//

import UIKit
import Alamofire

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
    
    @IBOutlet weak var pictureImageView: UIImageView!
    
    //MARK: Variables
    var cameraCount = 3
    var imagePicker = UIImagePickerController()

    
    var getCoffeeURL = "https://appserver.mobileinteraction.se/officeapi/rest/counter/viggurt-coffe-count/12h?forceUpdate=true"
    var getTeaURL = "https://appserver.mobileinteraction.se/officeapi/rest/counter/viggurt-tea-count/12h?forceUpdate=true"
    
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
/*
 let myImage = UIImage(data: try! Data(contentsOf: URL(string:"https://i.stack.imgur.com/Xs4RX.jpg")!))!
 UserDefaults.standard.set(image: myImage, forKey: "anyKey")
 if let myLoadedImage = UserDefaults.standard.image(forKey:"anyKey") {
 print(myLoadedImage.size)  // "(719.0, 808.0)"
 }
 
 let myImagesArray = [myImage, myImage]
 UserDefaults.standard.set(imageArray: myImagesArray, forKey: "imageArrayKey")
 if let myLoadedImages = UserDefaults.standard.imageArray(forKey:"imageArrayKey") {
 print(myLoadedImages.count)  // 2
 }*/
        callCoffeeAlamo(url: getCoffeeURL)
        callTeaAlamo(url: getTeaURL)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Functions
    func callCoffeeAlamo(url: String){
        Alamofire.request(url).responseJSON(completionHandler: { response in
            Coffee.parseData(JSONData: response.data!)
            self.coffeeCounter.text = String(Coffee.sharedInstance.cupCounter)
        
        })
    }
    
    func callTeaAlamo(url: String){
        Alamofire.request(url).responseJSON(completionHandler: { response in
            Tea.parseData(JSONData: response.data!)
            self.teaCountLabel.text = String(Tea.sharedInstance.cupCounter)
            
        })
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        
        pictureImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
    }
    
    func updateTeaTimer(){
        Tea.sharedInstance.counter += 1
        teaTimerLabel.text = "\(Tea.sharedInstance.counter) seconds"
        //Realm.io
        //Alamofire <- HTTP
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
        coffeeTimerLabel.text = "\(Coffee.sharedInstance.counter) seconds"
        Coffee.sharedInstance.timer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: #selector(updateCoffeeTimer), userInfo: nil, repeats: true)
        
        Coffee.sharedInstance.cupCounter += 1
        coffeeCounter.text = "\(Coffee.sharedInstance.cupCounter)"
    }
    
    @IBAction func coffeeCreatorButtonPressed(_ sender: AnyObject) {
        CoffeeCreator.sharedInstance.counter = 0
        CoffeeCreator.sharedInstance.timer.invalidate()
        coffeeCreatorTimer.text = "\(CoffeeCreator.sharedInstance.counter) seconds"
        CoffeeCreator.sharedInstance.timer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: #selector(updateCoffeeCreatorTimer), userInfo: nil, repeats: true)
        
        //Access camera on press
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.cameraDevice = UIImagePickerControllerCameraDevice.front
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
           
        }
        //Start countdown
        
        //Store picture backend
        
    }
}

extension UserDefaults {
    func set(_ image: UIImage?, forKey key: String) {
        guard let image = image else {
            return
        }
        set(UIImageJPEGRepresentation(image, 1.0), forKey: key)
    }
    func image(forKey key:String) -> UIImage? {
        guard let data = data(forKey: key), let image = UIImage(data: data )
            else  { return nil }
        return image
    }
    func set(imageArray value: [UIImage]?, forKey key: String) {
        guard let value = value else {
            return
        }
        set(NSKeyedArchiver.archivedData(withRootObject: value), forKey: key)
    }
    func imageArray(forKey key:String) -> [UIImage]? {
        guard  let data = data(forKey: key),
            let imageArray = NSKeyedUnarchiver.unarchiveObject(with: data) as? [UIImage]
            else { return nil }
        return imageArray
    }
}

