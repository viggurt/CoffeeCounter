//
//  CreatorTableViewController.swift
//  CoffeeCount
//
//  Created by Viktor on 2016-10-27.
//  Copyright © 2016 viggurt. All rights reserved.
//

import UIKit

class CreatorTableViewController: UITableViewController {

    //let vc = CameraViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Singleton.sharedInstance.employees)
        
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if Singleton.sharedInstance.imageSet == true{
            self.navigationController?.popViewController(animated: true)
            Singleton.sharedInstance.imageSet = false
        }
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Singleton.sharedInstance.employees.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "employeeCell", for: indexPath) as! EmployeeCell
        
        let cellName = Singleton.sharedInstance.employees[indexPath.row]
        
        cell.nameLabel.text = cellName.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cellName = Singleton.sharedInstance.employees[indexPath.row]

        Singleton.sharedInstance.nameOnCreator = cellName.name
        print(Singleton.sharedInstance.nameOnCreator)
        //present(vc, animated: true, completion: { _ in })
    }

   

}
