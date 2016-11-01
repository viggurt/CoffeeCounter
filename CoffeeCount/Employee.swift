//
//  Employee.swift
//  CoffeeCount
//
//  Created by Viktor on 2016-10-27.
//  Copyright © 2016 viggurt. All rights reserved.
//

import Foundation
import UIKit

class Employee{
    var name: String
    var id: Int
    
    var totalPoints: Int = 0
    
    
    //Uncomment if from data file
    init(dictionary: [String:AnyObject]) {
        self.name = dictionary["name"] as! String
        self.id = dictionary["idField"] as! Int 
    }
}
