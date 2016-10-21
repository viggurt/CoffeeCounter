//
//  PopOverViewController.swift
//  CoffeeCount
//
//  Created by Viktor on 2016-10-21.
//  Copyright © 2016 viggurt. All rights reserved.
//

import UIKit

class PopOverViewController: UIViewController {
 
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Singleton.sharedInstance.segmentState)
        print(segmentControl.numberOfSegments)
        
        if segmentControl.numberOfSegments >= Singleton.sharedInstance.segmentState{
            segmentControl.selectedSegmentIndex = Singleton.sharedInstance.segmentState
        }

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.performSegue(withIdentifier: "unwindToMain", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func indexChanged(_ sender: AnyObject) {
        
        switch segmentControl.selectedSegmentIndex{
        
        case 0:
            Coffee.sharedInstance.getLatestURL = "https://appserver.mobileinteraction.se/officeapi/rest/counter/viggurt-coffe-count/24h?forceUpdate=true"
            Tea.sharedInstance.getLatestURL = "https://appserver.mobileinteraction.se/officeapi/rest/counter/viggurt-tea-count/24h?forceUpdate=true"
            Singleton.sharedInstance.segmentState = 0
        case 1:
            Coffee.sharedInstance.getLatestURL = "https://appserver.mobileinteraction.se/officeapi/rest/counter/viggurt-coffe-count/7d?forceUpdate=true"
            Tea.sharedInstance.getLatestURL = "https://appserver.mobileinteraction.se/officeapi/rest/counter/viggurt-tea-count/7d?forceUpdate=true"
            Singleton.sharedInstance.segmentState = 1
        case 2:
            Coffee.sharedInstance.getLatestURL = "https://appserver.mobileinteraction.se/officeapi/rest/counter/viggurt-coffe-count/4w?forceUpdate=true"
            Tea.sharedInstance.getLatestURL = "https://appserver.mobileinteraction.se/officeapi/rest/counter/viggurt-tea-count/4w?forceUpdate=true"
            Singleton.sharedInstance.segmentState = 2

        case 3:
            Coffee.sharedInstance.getLatestURL = "https://appserver.mobileinteraction.se/officeapi/rest/counter/viggurt-coffe-count/52w?forceUpdate=true"
            Tea.sharedInstance.getLatestURL = "https://appserver.mobileinteraction.se/officeapi/rest/counter/viggurt-tea-count/52w?forceUpdate=true"
            Singleton.sharedInstance.segmentState = 3

            
        default:
            Singleton.sharedInstance.segmentState = 55

        
        }
        
    }
    
    

}
