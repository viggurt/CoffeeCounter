//
//  DataFile.swift
//  CoffeeCount
//
//  Created by Viktor on 2016-10-27.
//  Copyright © 2016 viggurt. All rights reserved.
//

import Foundation
import UIKit

class DataFile{
    
    static func getData(completion: @escaping (_ employee: [Employee]) ->()){
                
        var employeeArr = [Employee]()
        
/*session.dataTask(with: (url as URL?)!, completionHandler: { ( data: Data?, response: URLResponse?, error: Error? ) -> Void in
 
 guard let realResponse = response as? HTTPURLResponse ,
 realResponse.statusCode == 200 else {
 print("Not a 200 response")
 return
 }*/
        
            let jsonFile = Bundle.main.path(forResource: "Employees", ofType: "json")
        let jsonData = NSData(contentsOfFile: jsonFile!)
            // Parse the JSON to get the IP
            if let jsonDictionary = parseJSONFromData(jsonData: jsonData as NSData?){
                
               //studentFiles is an array with dictionaries
                let employeeFiles = jsonDictionary["employees"] as! [[String: AnyObject]]
                //Looping through to get every key and value
                for file in employeeFiles{
                    let employee = Employee(dictionary: file)
                    print(employee)
                    employeeArr.append(employee)
                }
        
                
                DispatchQueue.main.async {
                    completion(employeeArr)
                }
            }
            
        //}).resume()
        
        
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

extension DataFile{
    
    static func parseJSONFromData(jsonData: NSData?) -> [String:AnyObject]?{
        if let data = jsonData{
            do{
                let jsonDictionary = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:AnyObject]
                return jsonDictionary
            }catch{
                print("error \(error.localizedDescription)")
            }
        }
        
        return nil
    }
}

