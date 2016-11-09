//
//  CreatorTableViewController.swift
//  CoffeeCount
//
//  Created by Viktor on 2016-10-27.
//  Copyright © 2016 viggurt. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class PostStruct {
    
    init() {
        
    }
    
    var name : String!
    var point : Int!
    
    
    var ref : FIRDatabaseReference!
    
}

class CreatorTableViewController: UITableViewController {
    
    //let vc = CameraViewController()
    
    //var posts = [postStruct]()
    
    let databaseRef : FIRDatabaseReference! = nil
    
    @IBOutlet var employeeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Singleton.sharedInstance.employees)
        
       /* let databaseRef = FIRDatabase.database().reference()

        databaseRef.child("Employees").queryOrderedByKey().observe(.childAdded, with: {
            snapshot in
            
                let name = (snapshot.value as? NSDictionary)?["name"] as! String
                let point = (snapshot.value as? NSDictionary)?["point"] as! Int
            
            self.posts.insert(postStruct(name: name, point: point), at: 0)
            
            self.tableView.reloadData()

        })*/
        
        employeeTableView.allowsMultipleSelectionDuringEditing = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
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
        return Singleton.sharedInstance.posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "employeeCell", for: indexPath) as! EmployeeCell
        
        let cellName = Singleton.sharedInstance.posts[indexPath.row].name
        
        cell.nameLabel.text = cellName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cellName = Singleton.sharedInstance.posts[indexPath.row].name
        
        
        Singleton.sharedInstance.nameOnCreator = cellName!
        print(Singleton.sharedInstance.nameOnCreator)
        //present(vc, animated: true, completion: { _ in })
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            
                let employeePosts = Singleton.sharedInstance.posts[indexPath.row]
            
                employeePosts.ref.removeValue()
            Singleton.sharedInstance.posts.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
                /*
                FIRDatabase.database().reference().child("Employees").child(key).removeValue(completionBlock: { (error, ref) in
                
                    if error != nil{
                        print("Failed to delete message: ", error)
                        return
                    }
                    
                    Singleton.sharedInstance.posts.remove(at: indexPath.row)
                    self.tableView.deleteRows(at: [indexPath], with: .automatic)
                    
                
                })*/
                
        }
    }


}
