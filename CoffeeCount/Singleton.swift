//
//  Singleton.swift
//  CoffeeCount
//
//  Created by Viktor on 2016-10-21.
//  Copyright © 2016 viggurt. All rights reserved.
//

import Foundation
import UIKit

class Singleton {
 static var sharedInstance = Singleton()
    
    var segmentState = 55
    
    var myImage = UIImage()
    
    var nameOnCreator = ""
    
    var employeeNames = ["Viktor", "Någon annan","Kalle","Krister","Nog"]
    
    var employees = [Employee]()
    
    var tieList = [Employee]()
    
    
    var currentName: String = ""
    
    var highestPoint: [Int] = []
    
    func sort(){
        for employee in employees{

            
            if !highestPoint.contains(employee.totalPoints){
                self.highestPoint.append(employee.totalPoints)
            }
        }
        
        let sortedPoints = self.highestPoint.sorted(by: { (num1, num2) -> Bool in
            return num1 > num2
        })
        highestPoint = sortedPoints
        
        
        let sortedStudents = self.employees.sorted(by: { (stud1, stud2) -> Bool in
            return stud1.totalPoints > stud2.totalPoints
        })
        employees = sortedStudents
        
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

    
    
}
