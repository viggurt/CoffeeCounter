//
//  StatisticsViewController.swift
//  CoffeeCount
//
//  Created by Viktor on 2016-10-24.
//  Copyright © 2016 viggurt. All rights reserved.
//

import UIKit
import Alamofire

class StatisticsViewController: UIViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var dayCoffeeLabel: UILabel!
    @IBOutlet weak var dayTeaLabel: UILabel!
    
    @IBOutlet weak var weekCoffeeLabel: UILabel!
    @IBOutlet weak var weekTeaLabel: UILabel!
    
    @IBOutlet weak var monthCoffeeLabel: UILabel!
    @IBOutlet weak var monthTeaLabel: UILabel!
    
    @IBOutlet weak var yearCoffeeLabel: UILabel!
    @IBOutlet weak var yearTeaLabel: UILabel!
    
    //MARK: Variables
    //Days
    var dayCoffeeCups = 0
    var dayTeaCups = 0

    //Weeks
    var weekCoffeeCups = 0
    var weekTeaCups = 0

    //Month
    var monthCoffeeCups = 0
    var monthTeaCups = 0

    //Year
    var yearCoffeeCups = 0
    var yearTeaCups = 0
    
    var coffeeCups: [Int] = []
    var teaCups: [Int] = []
    var timeIntervalString: [String] = []
    
    var coffeeLabelArray: [UILabel] = []
    var teaLabelArray: [UILabel] = []

    
    var theCoffeePosition = 0
    var theTeaPosition = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coffeeCups = [dayCoffeeCups, weekCoffeeCups, monthCoffeeCups, yearCoffeeCups]
        teaCups = [dayTeaCups, weekTeaCups, monthTeaCups, yearTeaCups]
        timeIntervalString = ["24h","1w","4w","52w"]
        
        coffeeLabelArray = [dayCoffeeLabel, weekCoffeeLabel, monthCoffeeLabel, yearCoffeeLabel]
        teaLabelArray = [dayTeaLabel, weekTeaLabel, monthTeaLabel, yearTeaLabel]

        
        for i in 0..<timeIntervalString.count{
            let getCoffeeURL = "https://appserver.mobileinteraction.se/officeapi/rest/counter/viggurt-coffe-count/\(timeIntervalString[i])?forceUpdate=true"
            let getTeaURL = "https://appserver.mobileinteraction.se/officeapi/rest/counter/viggurt-tea-count/\(timeIntervalString[i])?forceUpdate=true"
        
            callCoffeeTotalAlamo(url: getCoffeeURL, labelToSet: coffeeLabelArray[i])
            callTeaTotalAlamo(url: getTeaURL, labelToSet: teaLabelArray[i])
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func callCoffeeTotalAlamo(url: String, labelToSet:UILabel){
        Alamofire.request(url, method: .get).responseJSON(completionHandler: { response in
            if let thetotalammount = Coffee.parseTotalData(JSONData: response.data!)
            //self.coffeeOverTimeLabel.text = String(Coffee.sharedInstance.cupsOverTimeCounter)
            {
                labelToSet.text = String(thetotalammount)
            }
         
        })
    }

    func callTeaTotalAlamo(url: String, labelToSet:UILabel){
        Alamofire.request(url, method: .get).responseJSON(completionHandler: { response in
            if let theTotalAmmount = Tea.parseTotalData(JSONData: response.data!){
            
                labelToSet.text = String(theTotalAmmount)
            }
            
        })
    }
 

}
