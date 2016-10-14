//
//  Tea.swift
//  CoffeeCount
//
//  Created by Viktor on 13/10/16.
//  Copyright © 2016 viggurt. All rights reserved.
//

import Foundation
import UIKit

class Tea{
    static var sharedInstance = Tea()

    var timer = Timer()

    var counter = 0

    var cupCounter = 0

    static func parseData(JSONData: Data){
        do{
            let readableJSON = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! [[String: AnyObject]]
            
            for dict in readableJSON{
                let sum = dict["sum"] as? Int
                
                //For the tea
                Tea.sharedInstance.cupCounter = sum!
                
            }
            
        } catch{
            print(error)
        }
        
        
    }

}
