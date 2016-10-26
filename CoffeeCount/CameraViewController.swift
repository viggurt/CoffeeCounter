//
//  CameraViewController.swift
//  CoffeeCount
//
//  Created by Viktor on 2016-10-25.
//  Copyright © 2016 viggurt. All rights reserved.
//

import UIKit
import AVFoundation
import Canvas

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var myView: UIView!
    var captureSession: AVCaptureSession! = nil
    var stillImageOutput: AVCaptureStillImageOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    var cameraCount = 3
    var timer = Timer()
    @IBOutlet weak var countDownAnimationView: CSAnimationView!
    @IBOutlet weak var countDownLabel: UILabel!
    
    @IBOutlet weak var cameraView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        myView.bringSubview(toFront: countDownAnimationView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        previewLayer?.frame = cameraView.bounds
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = AVCaptureSessionPreset1920x1080
        
        let backCamera = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
       
        
        
        let error: NSError? = nil
        
        do{
        let input = try AVCaptureDeviceInput(device: backCamera)
            
            print(captureSession.canAddInput(input))
            
            if error == nil && captureSession.canAddInput(input){
                captureSession?.addInput(input)
                
                stillImageOutput = AVCaptureStillImageOutput()
                if captureSession?.addOutput(stillImageOutput) != nil{
                    
                    previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                    previewLayer?.videoGravity = AVLayerVideoGravityResizeAspect
                    previewLayer?.connection.videoOrientation = AVCaptureVideoOrientation.portrait
                    cameraView.layer.addSublayer(previewLayer!)
                    captureSession?.startRunning()
                    stillImageOutput?.outputSettings = [AVVideoCodecKey:AVVideoCodecJPEG]
                    
                    timer.invalidate()
                    timer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
                }
                   
            }
            
        } catch{
            print(error)
        }
        
        
    }
    
    func capture(){
        if let videoConnection = stillImageOutput!.connection(withMediaType: AVMediaTypeVideo){
                stillImageOutput?.captureStillImageAsynchronously(from: videoConnection) {
                    (imageDataSampleBuffer, error) -> Void in
                    let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataSampleBuffer)
                    let finalImage = UIImage(data: imageData!)
                    Singleton.sharedInstance.myImage = finalImage!
                    self.navigationController?.popToRootViewController(animated: true)
                }
        }
    }
    
    func updateTimer(){
        print(self.cameraCount)
        cameraCount -= 1
        countDownLabel.text = String(cameraCount)
        countDownAnimationView.startCanvasAnimation()
        if self.cameraCount == 0{
            self.timer.invalidate()
            capture()
            self.cameraCount = 3
        }
    }

}
