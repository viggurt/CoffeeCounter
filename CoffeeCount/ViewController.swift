//
//  ViewController.swift
//  CoffeeCount
//
//  Created by Viktor on 07/10/16.
//  Copyright © 2016 viggurt. All rights reserved.
//

import UIKit
import Alamofire
import Canvas
import AVFoundation

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPopoverPresentationControllerDelegate {
    
    //MARK: Outlets
    @IBOutlet weak var quoteLabel: UILabel!
    
    @IBOutlet weak var coffeeButtonAnimationView: CSAnimationView!
    @IBOutlet weak var teaButtonAnimationView: CSAnimationView!
    @IBOutlet weak var plusOneAnimationView: CSAnimationView!
  
    @IBOutlet var myView: UIView!
    
    @IBOutlet weak var plusOneImage: UIImageView!
    @IBOutlet weak var teaButton: UIButton!
    @IBOutlet weak var coffeeButton: UIButton!
    @IBOutlet weak var coffeeCreator: UIButton!
    @IBOutlet weak var coffeeCounter: UILabel!
    @IBOutlet weak var teaCountLabel: UILabel!
    
    @IBOutlet weak var pictureImageView: UIImageView!
    
    @IBOutlet weak var rateTheCoffeLabel: UILabel!
    @IBOutlet weak var minusOne: UIButton!
    @IBOutlet weak var plusOne: UIButton!
    @IBOutlet weak var plusTwo: UIButton!
    
    @IBOutlet weak var statisticBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var highscoreBarButtonItem: UIBarButtonItem!
    
    
    
    //MARK: Variables
    var cameraCount = 3
    var imagePicker = UIImagePickerController()
    var getDataTimer = Timer()
    
    var putCoffeeURL = "https://appserver.mobileinteraction.se/officeapi/rest/counter/\(Singleton.sharedInstance.coffeeURLSwitch[Singleton.sharedInstance.urlState])/1"
    var putTeaURL = "https://appserver.mobileinteraction.se/officeapi/rest/counter/\(Singleton.sharedInstance.teaURLSwitch[Singleton.sharedInstance.urlState])/1"
    
    var teaImage = UIImage(named: "group-4")
    var coffeeImage = UIImage(named: "group-5")
    var unhappy = UIImage(named: "group-2")
    var happy = UIImage(named: "group")
    var inLove = UIImage(named: "group-1")
    var failedPutURLStrings: [String] = []
    var employee: Employee!
    
    var circleButtons: [UIButton] = []
    
    var sortingForEmployees = SortingForEmployees()
    
    var state = Singleton.sharedInstance.urlState

    override func viewDidLoad() {
        super.viewDidLoad()
 
        callAlamo(url: Coffee.sharedInstance.getCoffeeURL, labelToSet: coffeeCounter)
        callAlamo(url: Tea.sharedInstance.getTeaURL, labelToSet: teaCountLabel)
        
        circleButtons = [coffeeCreator, minusOne, plusOne, plusTwo]
   
        
        //MARK: Buttondesigns
     
        for button in circleButtons{
            button.layer.cornerRadius = button.bounds.size.width * 0.5
        }

        coffeeButtonAnimationView.layer.cornerRadius = coffeeButtonAnimationView.bounds.size.width * 0.5
        teaButtonAnimationView.layer.cornerRadius = teaButtonAnimationView.bounds.size.width * 0.5
        
        //MARK: Employees
        DataFile.getData(completion: { (employeeData) in
            Singleton.sharedInstance.employees = employeeData
            
            self.sortingForEmployees.sort()
            self.sortingForEmployees.compareIfMultipleStudentHaveTheHighestScore()
        
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pictureImageView.image = Singleton.sharedInstance.myImage

        //When someone has brewed coffee this becomes true
        if Singleton.sharedInstance.nameOnCreator != ""{
        quoteLabel.text = "\(Singleton.sharedInstance.nameOnCreator) - latest hero, making Coffee."
            minusOne.isHidden = false
            plusOne.isHidden = false
            plusTwo.isHidden = false
            rateTheCoffeLabel.isHidden = false
            self.pictureImageView.isHidden = false
            self.quoteLabel.isHidden = false
            pictureImageView.layer.cornerRadius = pictureImageView.bounds.size.width * 0.5
            pictureImageView.clipsToBounds = true
            
        }
        
        //This functions updates the data from the internet
        updateGetData()
        self.getDataTimer = Timer.scheduledTimer(timeInterval: 60, target:self, selector: #selector(self.updateGetData), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        getDataTimer.invalidate()
    }
    
    //MARK: Functions
    func updateGetData(){
        print("updateGetData")
        callAlamo(url: Coffee.sharedInstance.getCoffeeURL, labelToSet: coffeeCounter)
        callAlamo(url: Tea.sharedInstance.getTeaURL, labelToSet: teaCountLabel)
    }
    
    func callAlamo(url: String, labelToSet: UILabel){
        Alamofire.request(url, method: .get).responseJSON(completionHandler: { response in
            
            if let theTotalAmmount = DataFile.parseTotalData(JSONData: response.data!){
                
                    labelToSet.text = String(theTotalAmmount)
               
            }
        })
    }

    func putAlamo(url: String){
        print("putAlamo START")

        let putRequest = Alamofire.request(url, method: .put).validate().responseJSON(completionHandler: { response in
            
            switch response.result {
            case .success:
                print("Validation Successful")
                
                for putUrl in 0..<self.failedPutURLStrings.count{
                    self.putAlamo(url: self.failedPutURLStrings[putUrl])
                }
                print("removeAll")
                self.failedPutURLStrings.removeAll()
            case .failure:
                print("putAlamo failure, adding url: \(url)")
                self.failedPutURLStrings.append(url)
            }
        })
    }
    
    func dismissFullscreenImage(sender: UITapGestureRecognizer) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        sender.view?.removeFromSuperview()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        
        pictureImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
    }
   
    //MARK: Actions
    @IBAction func teaButtonPressed(_ sender: AnyObject) {
        Tea.sharedInstance.cupCounter += 1
        teaCountLabel.text = "\(Tea.sharedInstance.cupCounter)"
        
        //Add data
        putAlamo(url: putTeaURL)
        teaButtonAnimationView.startCanvasAnimation()
        plusOneAnimationView.backgroundColor = UIColor.init(red: 170/255, green: 143/255, blue: 121/255
            , alpha: 1)
        plusOneImage.image = teaImage
        myView.bringSubview(toFront: plusOneAnimationView)
        plusOneAnimationView.startCanvasAnimation()

    }
    
    @IBAction func coffeeButtonPressed(_ sender: AnyObject) {
        Coffee.sharedInstance.cupCounter += 1
        coffeeCounter.text = "\(Coffee.sharedInstance.cupCounter)"
        
        //Add data
        putAlamo(url: putCoffeeURL)
        print(Coffee.sharedInstance.cupCounter)
        print(Tea.sharedInstance.cupCounter)
        coffeeButtonAnimationView.startCanvasAnimation()
        plusOneAnimationView.backgroundColor = UIColor.init(red: 116/255, green: 76/255, blue: 40/255, alpha: 1)
        plusOneImage.image = coffeeImage
        myView.bringSubview(toFront: plusOneAnimationView)
        plusOneAnimationView.startCanvasAnimation()
    }
    
    @IBAction func coffeeCreatorButtonPressed(_ sender: AnyObject) {
 
        
    }
    
    @IBAction func minusOneButton(_ sender: AnyObject) {
        for employee in Singleton.sharedInstance.employees{
            if employee.name == Singleton.sharedInstance.nameOnCreator{
                Singleton.sharedInstance.putPointsURL = "https://appserver.mobileinteraction.se/officeapi/rest/counter/\(Singleton.sharedInstance.statURLSwitch[state])-\(employee.id)/-1"
                putAlamo(url: Singleton.sharedInstance.putPointsURL)
                //employee.totalPoints = employee.totalPoints - 1
            }
            
        }
        plusOneAnimationView.backgroundColor = nil

        plusOneImage.image = unhappy
        myView.bringSubview(toFront: plusOneAnimationView)
        plusOneAnimationView.startCanvasAnimation()
    }
    
    @IBAction func plusOneButton(_ sender: AnyObject) {
        for employee in Singleton.sharedInstance.employees{
            if employee.name == Singleton.sharedInstance.nameOnCreator{
                Singleton.sharedInstance.putPointsURL = "https://appserver.mobileinteraction.se/officeapi/rest/counter/\(Singleton.sharedInstance.statURLSwitch[state])-\(employee.id)/1"
                putAlamo(url: Singleton.sharedInstance.putPointsURL)

                //employee.totalPoints = employee.totalPoints + 1
            }
        }
        plusOneAnimationView.backgroundColor = nil

        plusOneImage.image = happy
        myView.bringSubview(toFront: plusOneAnimationView)
        plusOneAnimationView.startCanvasAnimation()
    }
    
    @IBAction func plusTwoButton(_ sender: AnyObject) {
        for employee in Singleton.sharedInstance.employees{
            if employee.name == Singleton.sharedInstance.nameOnCreator{
                Singleton.sharedInstance.putPointsURL = "https://appserver.mobileinteraction.se/officeapi/rest/counter/\(Singleton.sharedInstance.statURLSwitch[state])-\(employee.id)/2"
                putAlamo(url: Singleton.sharedInstance.putPointsURL)

                //employee.totalPoints = employee.totalPoints + 2
            }
        }
        plusOneAnimationView.backgroundColor = nil

        plusOneImage.image = inLove
        myView.bringSubview(toFront: plusOneAnimationView)
        plusOneAnimationView.startCanvasAnimation()
        
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    //http://stackoverflow.com/questions/34694377/swift-how-can-i-make-an-image-full-screen-when-clicked-and-then-original-size
    @IBAction func imageTapped(sender: UITapGestureRecognizer) {
        let imageView = sender.view as! UIImageView
        let fullscreenPhoto = UIImageView(image: imageView.image)
        fullscreenPhoto.frame = self.pictureImageView.frame
        fullscreenPhoto.contentMode = .scaleAspectFit
        self.view.addSubview(fullscreenPhoto)

        fullscreenPhoto.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage(sender:)) )
        
        fullscreenPhoto.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let windowFrame = self.view.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveLinear, animations: {
            
            fullscreenPhoto.frame = windowFrame
            fullscreenPhoto.alpha = 1
            fullscreenPhoto.backgroundColor = .white

            }, completion: { _ in
        })
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        fullscreenPhoto.addGestureRecognizer(tap)
        
    }
    
}

//Extension for the camera
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
