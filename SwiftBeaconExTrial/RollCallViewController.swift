//
//  RollCallViewController.swift
//  SwiftBeaconExTrial
//
//  Created by Erik Hoversten on 13.08.15.
//  Copyright (c) 2015 EverProductions. All rights reserved.
//

import UIKit
import Parse

class RollCallViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var rollCallUserArray = [PFUser]()
    
    @IBOutlet var rollCallTableView : UITableView!
    
    
    // MARK : Parse Methods
    
    func fetchRollCallUsers()  {
        if let queryX = PFUser.query() {
            queryX.addDescendingOrder("isInBuilding")
            queryX.addAscendingOrder("username")
            queryX.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
                self.rollCallUserArray = (objects as! [PFUser])
                self.rollCallTableView.reloadData()
            }
        }
    
    }
    
    // MARK : TableView Methods
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rollCallUserArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        let currentPerson = rollCallUserArray[indexPath.row]
        print("user: \(currentPerson.username)")
        cell.textLabel!.text = currentPerson.username
        
        
        // Check to see if user has entered the Beacon Monitoring Region and unwrap object
        if let x: AnyObject = currentPerson["isInBuilding"] {
            print("not null")
            let isInBuilding = currentPerson["isInBuilding"]! as! Bool
            if isInBuilding {
                cell.backgroundColor = UIColor.greenColor()
                if let currentRoom = currentPerson["currentRoom"]! as? String {
                    cell.detailTextLabel!.text = currentRoom
                } else {
                    cell.detailTextLabel!.text = "Unknown Room"
                }
            } else {
                cell.backgroundColor = UIColor.redColor()
                cell.detailTextLabel!.text = "Not In Building"
            }
        } else {
            print("null")
            cell.backgroundColor = UIColor.lightGrayColor()
            cell.detailTextLabel!.text = "User Not Logged In"
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // add code to not highlight selected row
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        rollCallTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        fetchRollCallUsers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
