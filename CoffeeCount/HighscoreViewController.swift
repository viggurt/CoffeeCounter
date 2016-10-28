//
//  HighscoreViewController.swift
//  CoffeeCount
//
//  Created by Viktor on 2016-10-27.
//  Copyright © 2016 viggurt. All rights reserved.
//

import UIKit

class HighscoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var scoreBoard: UITableView!
    @IBOutlet weak var topScoreName: UILabel!
    @IBOutlet weak var topScorePoint: UILabel!
    //@IBOutlet weak var tieScoreBoard: UITableView!
    @IBOutlet weak var tieScoreBoard: UITableView!
    @IBOutlet weak var coffeebrewersLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        Singleton.sharedInstance.sort()
        Singleton.sharedInstance.compareIfMultipleStudentHaveTheHighestScore()
        
        scoreBoard.dataSource = self
        scoreBoard.delegate = self
        
        tieScoreBoard.dataSource = self
        tieScoreBoard.delegate = self
        
        
        if Singleton.sharedInstance.tieList.count > 1{
            print("number in tie list \(Singleton.sharedInstance.tieList.count)")
            self.tieScoreBoard.isHidden = false
            coffeebrewersLabel.text = "The best coffeebrewers!"
        }else{
            self.topScoreName.text = Singleton.sharedInstance.employees[0].name
        }
        
        self.topScoreName.text = Singleton.sharedInstance.employees[0].name
        
        self.topScorePoint.text = "With \(Singleton.sharedInstance.employees[0].totalPoints) points!"
        
        self.scoreBoard.reloadData()
        self.tieScoreBoard.reloadData()
    
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
