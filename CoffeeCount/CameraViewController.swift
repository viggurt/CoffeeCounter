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
    var cameraPosition: AVCaptureDevicePosition?
    var previewLayer: AVCaptureVideoPreviewLayer?
    var cameraCount: Int!
    var timer = Timer()
    let VC = ViewController()
    let creatorVC = CreatorTableViewController()
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
        cameraCount = 3
        previewLayer?.frame = cameraView.bounds
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = AVCaptureSessionPresetHigh
        let cameraDevice = AVCaptureDevice.defaultDevice(withDeviceType: AVCaptureDeviceType.builtInWideAngleCamera , mediaType: AVMediaTypeVideo, position: AVCaptureDevicePosition.front)
       print(cameraDevice!)
        
        
        let error: NSError? = nil
        
        do{
        let input = try AVCaptureDeviceInput(device: cameraDevice)
            
            print(captureSession.canAddInput(input))
            
            if error == nil && captureSession.canAddInput(input){
                captureSession?.addInput(input)
                
                stillImageOutput = AVCaptureStillImageOutput()
                if captureSession.canAddOutput(stillImageOutput){
                    captureSession.addOutput(stillImageOutput)
                    previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                    previewLayer?.videoGravity = AVLayerVideoGravityResizeAspect
                    previewLayer?.connection.videoOrientation = AVCaptureVideoOrientation.portrait
                    cameraView.layer.addSublayer(previewLayer!)
                    stillImageOutput?.outputSettings = [AVVideoCodecKey:AVVideoCodecJPEG]
                    
                    timer.invalidate()
                    timer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
                    
                    captureSession?.startRunning()
                }
                
            }
            
        } catch{
            print("YOU GOT THIS ERROR \(error)")
        }
        
        
    }
    
    func capture(){
        if let videoConnection = stillImageOutput!.connection(withMediaType: AVMediaTypeVideo){
                stillImageOutput?.captureStillImageAsynchronously(from: videoConnection) {
                    (imageDataSampleBuffer, error) -> Void in
                    let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataSampleBuffer)
                    let finalImage = UIImage(data: imageData!)
                    let thaImage = UIImage(cgImage: (finalImage?.cgImage)!, scale: 1.0, orientation: UIImageOrientation.leftMirrored)
                    Singleton.sharedInstance.myImage = thaImage
                    print("CAPTURUD")
                    Singleton.sharedInstance.imageSet = true
                    //self.navigationController?.popToRootViewController(animated: true)
                    self.dismiss(animated: true, completion: { _ in
                    })
                }
        }
    }
    
    func updateTimer(){
        cameraCount! -= 1
        print(self.cameraCount)
        if self.cameraCount == 1{
            countDownLabel.text = "Smile!"
        }
        
        countDownAnimationView.startCanvasAnimation()
        if self.cameraCount == 0{
            countDownLabel.text = "Snap"
            self.timer.invalidate()
            capture()
        }
    }

}
