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

}
