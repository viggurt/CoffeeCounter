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
    
    var cupCounter = 0
    var getCoffeeURL = "https://appserver.mobileinteraction.se/officeapi/rest/counter/\(Singleton.sharedInstance.coffeeURLSwitch[Singleton.sharedInstance.urlState])/12h?forceUpdate=true"

}
