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
    var cupCounter = 0
    var getTeaURL = "https://appserver.mobileinteraction.se/officeapi/rest/counter/\(Singleton.sharedInstance.teaURLSwitch[Singleton.sharedInstance.urlState])/12h?forceUpdate=true"

}
