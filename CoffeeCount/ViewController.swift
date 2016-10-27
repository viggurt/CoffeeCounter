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
    
    //MARK: Variables
    var cameraCount = 3
    var imagePicker = UIImagePickerController()
    
    var timer = Timer()
    var getDataTimer = Timer()
    
    var putCoffeeURL = "https://appserver.mobileinteraction.se/officeapi/rest/counter/viggurt-coffe-count/1"
    var putTeaURL = "https://appserver.mobileinteraction.se/officeapi/rest/counter/viggurt-tea-count/1"
    
    var teaImage = UIImage(named: "teaImage")
    var coffeeImage = UIImage(named: "coffeeImage")
    var quoteList: [String] = []
    var failedPutURLStrings: [String] = []
    //let session = AVCaptureSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        callCoffeeAlamo(url: Coffee.sharedInstance.getCoffeeURL)
        callTeaAlamo(url: Tea.sharedInstance.getTeaURL)
        
        //Buttondesigns
        teaButton.layer.cornerRadius = 5
        coffeeButton.layer.cornerRadius = 10
        coffeeCreator.layer.cornerRadius = coffeeCreator.bounds.size.width * 0.5
        
        teaButton.layer.shadowColor = UIColor.lightGray.cgColor
        teaButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        teaButton.layer.shadowRadius = 5
        teaButton.layer.shadowOpacity = 1
        
        coffeeButton.layer.shadowColor = UIColor.lightGray.cgColor
        coffeeButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        coffeeButton.layer.shadowRadius = 5
        coffeeButton.layer.shadowOpacity = 1
        
        coffeeCreator.layer.shadowColor = UIColor.lightGray.cgColor
        coffeeCreator.layer.shadowOffset = CGSize(width: 5, height: 5)
        coffeeCreator.layer.shadowRadius = 5
        coffeeCreator.layer.shadowOpacity = 1
        
      print("VIEW LOADED")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Layout Functions
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        
        if UIDevice.current.orientation.isLandscape{
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("VIEW APPEARD")
        pictureImageView.image = Singleton.sharedInstance.myImage
        quoteLabel.text = "\(Singleton.sharedInstance.nameOnCreator)! Making coffee-lovers day a little bit better."
        updateGetData()
        self.getDataTimer = Timer.scheduledTimer(timeInterval: 300, target:self, selector: #selector(self.updateGetData), userInfo: nil, repeats: true)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        getDataTimer.invalidate()
        print("VIEW DISSAPURRD")
    }
    
    //MARK: Functions
    func updateGetData(){
        print("updateGetData")
        callCoffeeAlamo(url: Coffee.sharedInstance.getCoffeeURL)
        callTeaAlamo(url: Tea.sharedInstance.getTeaURL)
    }
    
    func callCoffeeAlamo(url: String){
        Alamofire.request(url, method: .get).responseJSON(completionHandler: { response in
            switch response.result{
            case .success(let data):
                Coffee.parseData(JSONData: response.data!)
                self.coffeeCounter.text = String(Coffee.sharedInstance.cupCounter)
            case .failure(let error):
                print("Request failed with error: \(error)")
            }
        
        })
    }
    
    func callTeaAlamo(url: String){
        Alamofire.request(url, method: .get).responseJSON(completionHandler: { response in
            Tea.parseData(JSONData: response.data!)
            self.teaCountLabel.text = String(Tea.sharedInstance.cupCounter)
            
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
    
    
    //http://stackoverflow.com/questions/35215694/format-timer-label-to-hoursminutesseconds-in-swift
    func timeString(time: Int) -> String {
        let hours = time / 3600
        let minutes = time / 60 % 60
        let seconds = time % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
   
    
    //MARK: Actions
    @IBAction func teaButtonPressed(_ sender: AnyObject) {
        Tea.sharedInstance.cupCounter += 1
        teaCountLabel.text = "\(Tea.sharedInstance.cupCounter)"
        
        //Add data
        putAlamo(url: putTeaURL)
        teaButtonAnimationView.startCanvasAnimation()
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
        plusOneImage.image = coffeeImage
        myView.bringSubview(toFront: plusOneAnimationView)
        plusOneAnimationView.startCanvasAnimation()
    }
    
    @IBAction func coffeeCreatorButtonPressed(_ sender: AnyObject) {
 
        self.pictureImageView.isHidden = false
        self.quoteLabel.isHidden = false
    }
 
    func updateTimer(){
        print(self.cameraCount)
        cameraCount -= 1
        if self.cameraCount == 0{
            self.timer.invalidate()
            self.imagePicker.takePicture()
            self.cameraCount = 3
        }
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
