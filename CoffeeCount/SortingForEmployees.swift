//
//  SortingForEmployees.swift
//  CoffeeCount
//
//  Created by Viktor on 2016-11-03.
//  Copyright © 2016 viggurt. All rights reserved.
//

import Foundation
class SortingForEmployees{
    
    var point = 0
    
    func sort(){
        for employee in Singleton.sharedInstance.employees{
            
            Singleton.sharedInstance.highestPoint.removeAll()
            point = point + employee.totalPoints
            
            if !Singleton.sharedInstance.highestPoint.contains(point){
                Singleton.sharedInstance.highestPoint.append(point)
            }
            point = 0
        }
        
        if Singleton.sharedInstance.highestPoint.count > 1{
            let sortedPoints = Singleton.sharedInstance.highestPoint.sorted(by: { (num1, num2) -> Bool in
                return num1 > num2
            })
            Singleton.sharedInstance.highestPoint = sortedPoints
        }
        
        print(Singleton.sharedInstance.employees[0].name)
        let sortedStudents = Singleton.sharedInstance.employees.sorted(by: { (stud1, stud2) -> Bool in
            return stud1.totalPoints > stud2.totalPoints
        })
        Singleton.sharedInstance.employees = sortedStudents
        print(Singleton.sharedInstance.employees[0].name)
        Singleton.sharedInstance.tieList.removeAll()
        if !Singleton.sharedInstance.employees.isEmpty{
            Singleton.sharedInstance.tieList.append(Singleton.sharedInstance.employees[0])
        }
        
    }
    
    
    func compareIfMultipleStudentHaveTheHighestScore(){
        
        //If multiple students have the highest score, they all will be visable in the top
        if !Singleton.sharedInstance.tieList.isEmpty{
            for employee in Singleton.sharedInstance.employees{
                if employee.totalPoints == Singleton.sharedInstance.tieList[0].totalPoints{
                    if !Singleton.sharedInstance.tieList.contains(where: { (studInArr) -> Bool in
                        return studInArr.name == employee.name
                    }){
                        Singleton.sharedInstance.tieList.append(employee)
                    }
                }
            }
        }
        
    }
}
