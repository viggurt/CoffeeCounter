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
    
    var imageSet = false
    
    var nameOnCreator = ""
    
    var employeeNames = ["Fredrik","Erik","Jonas","Petrus","Andreas","Wille","Zintis","Christine","Victor","Martin","Viggurt","Virro","Emilia","Activade"]
    
    var employees = [Employee]()
    
    var point = 0
    
    var tieList = [Employee]()
    
    var coffeeURLSwitch: [String] = ["coffee-count","viggurt-coffe-count"]
    
    var teaURLSwitch: [String] = ["tea-count","viggurt-tea-count"]
    
    var highestPoint: [Int] = []
    
    func sort(){
        for employee in employees{
            point = 0
            
            point = point + employee.totalPoints
            
            if !highestPoint.contains(point){
                self.highestPoint.append(point)
            }
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

    
    
}
