//
//  CreatorTableViewController.swift
//  CoffeeCount
//
//  Created by Viktor on 2016-10-27.
//  Copyright © 2016 viggurt. All rights reserved.
//

import UIKit

class CreatorTableViewController: UITableViewController {

    var employee: [String] = []
    //let vc = CameraViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        employee = ["Viktor", "Någon annan"]
        tableView.reloadData()
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return employee.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "employeeCell", for: indexPath) as! EmployeeCell
        
        cell.nameLabel.text = employee[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Singleton.sharedInstance.nameOnCreator = employee[indexPath.row]
        print(Singleton.sharedInstance.nameOnCreator)
        //present(vc, animated: true, completion: { _ in })
    }

   

}
