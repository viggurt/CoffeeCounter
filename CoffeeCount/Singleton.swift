//
//  Singleton.swift
//  CoffeeCount
//
//  Created by Viktor on 2016-10-21.
//  Copyright © 2016 viggurt. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class Singleton {
 static var sharedInstance = Singleton()
    
    var myImage = UIImage()
    
    var imageSet = false
    
    var nameOnCreator = ""
        
    var employees = [Employee]()
    
    var putPointsURL = "https://appserver.mobileinteraction.se/officeapi/rest/counter/coffee-count-stats-%d/%d"

    var tieList = [Employee]()
    
    //if urlState == "1" it gets data from my personal json. else if urlState is "0" it is from the main json
    var urlState: Int = 0
    
    var coffeeURLSwitch: [String] = ["coffee-count","viggurt-coffe-count"]
    
    var teaURLSwitch: [String] = ["tea-count","viggurt-tea-count"]
    
    var statURLSwitch: [String] = ["coffee-count-stats","viggurt-coffee-count-stats"]
    
    let statURL = "https://appserver.mobileinteraction.se/officeapi/rest/counter/coffee-count-stats-%d/1200w?forceUpdate=true"
    
    func urlForEmployee(empl:Employee) -> String
    {
        let statURLFormatted = String(format: statURL, empl.id)
      
        return statURLFormatted
    }
    
    var highestPoint: [Int] = []

    
    func callScoreAlamo(completion: @escaping(_ pointFromData: Int) -> ()) -> Void {
        
        for employee in employees{
            let theurl = urlForEmployee(empl: employee)
        
        Alamofire.request(theurl, method: .get).responseJSON(completionHandler: { response in
            if let thetotalammount = DataFile.parseTotalData(JSONData: response.data!)
            {
                employee.totalPoints = thetotalammount
            }
            
            DispatchQueue.main.async {
                completion(employee.totalPoints)
            }
        })
            
        }
        
    }
    
  
}
