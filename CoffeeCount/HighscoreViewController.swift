//
//  HighscoreViewController.swift
//  CoffeeCount
//
//  Created by Viktor on 2016-10-27.
//  Copyright © 2016 viggurt. All rights reserved.
//

import UIKit
import Alamofire

class HighscoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var scoreBoard: UITableView!
    @IBOutlet weak var topScoreName: UILabel!
    @IBOutlet weak var topScorePoint: UILabel!
    @IBOutlet weak var tieScoreBoard: UITableView!
    @IBOutlet weak var coffeebrewersLabel: UILabel!
    

    var state = Singleton.sharedInstance.urlState
    
    var sortingForEmployees = SortingForEmployees()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        Singleton.sharedInstance.callScoreAlamo(completion: { (pointData) in
            
            
            self.tieScoreBoard.isHidden = true
            self.scoreBoard.dataSource = self
            self.scoreBoard.delegate = self
            
            self.tieScoreBoard.dataSource = self
            self.tieScoreBoard.delegate = self
            
            self.sortingForEmployees.sort()
            self.sortingForEmployees.compareIfMultipleStudentHaveTheHighestScore()
            
            print(Singleton.sharedInstance.highestPoint)
            if Singleton.sharedInstance.tieList.count > 1{
                print("number in tie list \(Singleton.sharedInstance.tieList.count)")
                self.tieScoreBoard.isHidden = false
                self.coffeebrewersLabel.text = "The best coffeebrewers!"
            }else{
                self.topScoreName.text = Singleton.sharedInstance.employees[0].name
            }
            
            self.topScoreName.text = Singleton.sharedInstance.employees[0].name
            
            self.topScorePoint.text = "\(Singleton.sharedInstance.employees[0].totalPoints) points!"
            
            self.scoreBoard.reloadData()
            self.tieScoreBoard.reloadData()
            
            
            
            
        })
        
            //Singleton.sharedInstance.sort()
            //Singleton.sharedInstance.compareIfMultipleStudentHaveTheHighestScore()
    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var cellCount: Int!
        
        if tableView == scoreBoard{
            cellCount = Singleton.sharedInstance.employees.count
        }
        
        if tableView == tieScoreBoard{
                cellCount = Singleton.sharedInstance.tieList.count
            
        }
        
        return cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        
        if tableView == scoreBoard{
            let mCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HighscoreCell
            cell = mCell
            
            let content = Singleton.sharedInstance.employees[indexPath.row]
            mCell.nameLabel.text = content.name
            
            mCell.pointLabel.text = String(content.totalPoints)
            
        }
        
        if tableView == tieScoreBoard{
                let tCell = tableView.dequeueReusableCell(withIdentifier: "tieCell", for: indexPath) as! TieCell
                cell = tCell
                
                let content = Singleton.sharedInstance.tieList[indexPath.row]
                
                tCell.nameLabel.text = content.name
                
            
        }
        return cell
}

}
