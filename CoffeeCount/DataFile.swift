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
        
        let postEndPoint: String = ""
        let url = NSURL(string: postEndPoint)!
        let session = URLSession.shared
        var employeeArr = [Employee]()
        
        session.dataTask(with: (url as URL?)!, completionHandler: { ( data: Data?, response: URLResponse?, error: Error? ) -> Void in
            
            guard let realResponse = response as? HTTPURLResponse ,
                realResponse.statusCode == 200 else {
                    print("Not a 200 response")
                    return
            }
            
            // Parse the JSON to get the IP
            if let jsonDictionary = parseJSONFromData(jsonData: data as NSData?){
                
               /* //studentFiles is an array with dictionaries
                let studentFiles = jsonDictionary["students"] as! [[String: AnyObject]]
                //Looping through to get every key and value
                for file in studentFiles{
                    let student = Students(dictionary: file)
                    print(student)
                    studentArr.append(student)
                }*/
        
                
                DispatchQueue.main.async {
                    completion(employeeArr)
                }
            }
            
        }).resume()
        
        
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

