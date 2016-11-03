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
    
    var point = 0
    
    var tieList = [Employee]()
    
    //if urlState == "1" it gets data from my personal json. else if urlState is "0" it is from the main json
    var urlState: Int = 1
    
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
    
    func sort(){
        for employee in employees{
            
            highestPoint.removeAll()
            point = point + employee.totalPoints
            
            if !highestPoint.contains(point){
                self.highestPoint.append(point)
            }
            point = 0
        }
        
        if highestPoint.count > 1{
        let sortedPoints = self.highestPoint.sorted(by: { (num1, num2) -> Bool in
            return num1 > num2
        })
        highestPoint = sortedPoints
        }
        
        print(employees[0].name)
        let sortedStudents = self.employees.sorted(by: { (stud1, stud2) -> Bool in
            return stud1.totalPoints > stud2.totalPoints
        })
        employees = sortedStudents
        print(employees[0].name)
        tieList.removeAll()
        if !employees.isEmpty{
            tieList.append(employees[0])
        }
        
    }
    
        
    func compareIfMultipleStudentHaveTheHighestScore(){
        
        //If multiple students have the highest score, they all will be visable in the top
        if !tieList.isEmpty{
            for employee in employees{
                if employee.totalPoints == tieList[0].totalPoints{
                    if !tieList.contains(where: { (studInArr) -> Bool in
                        return studInArr.name == employee.name
                    }){
                        self.tieList.append(employee)
                    }
                }
            }
        }
        
    }
    
    func callScoreAlamo(completion: @escaping(_ pointFromData: Int) -> ()) -> Void {
        
        for employee in employees{
            let theurl = urlForEmployee(empl: employee)
        
        Alamofire.request(theurl, method: .get).responseJSON(completionHandler: { response in
            if let thetotalammount = Singleton.parseTotalData(JSONData: response.data!)
            {
                employee.totalPoints = thetotalammount
            }
            
            DispatchQueue.main.async {
                completion(employee.totalPoints)
            }
        })
            
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
