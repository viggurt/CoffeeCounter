//
//  Coffee.swift
//  CoffeeCount
//
//  Created by Viktor on 13/10/16.
//  Copyright © 2016 viggurt. All rights reserved.
//

import Foundation
import UIKit

class Coffee {
    static var sharedInstance = Coffee()
    
    var timer = Timer()
    var counter = 0
    var cupCounter = 0
    //var cupsOverTimeCounter = 0
    var getCoffeeURL = "https://appserver.mobileinteraction.se/officeapi/rest/counter/\(Singleton.sharedInstance.coffeeURLSwitch[Singleton.sharedInstance.urlState])/12h?forceUpdate=true"
    var getLatestURL = ""
    
    static func parseData(JSONData: Data){
        do{
            let readableJSON = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! [[String: AnyObject]]
            
            for dict in readableJSON{
                let sum = dict["sum"] as? Int
                
                //For the coffee
                Coffee.sharedInstance.cupCounter = sum!
               
            }
            
        } catch{
            print(error)
        }
    }
    
    static func parseTotalData(JSONData: Data) -> Int?{
        do{
            let readableJSON = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! [[String: AnyObject]]
            
            for dict in readableJSON{
                let sum = dict["sum"] as? Int
                
                return sum
                
            }
            
        } catch{
            print(error)
            return nil
        }
        
        
        return nil
    }


}
