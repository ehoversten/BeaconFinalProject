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
    
    var rollCallUserArray : [PFUser]?
    
    @IBOutlet var rollCallTableView : UITableView!
    
    
    // MARK : Parse Methods
    
    func fetchRollCallUsers()  {
        var queryX = PFUser.query()
        queryX?.addDescendingOrder("isInBuilding")
        queryX?.addAscendingOrder("username")
        rollCallUserArray = queryX?.findObjects() as? [PFUser]
        println("UserCount: \(rollCallUserArray?.count)")
        
//        let query = PFQuery(className: "Attendance")
//        query.addAscendingOrder("dataSent")
//        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
//            if error == nil {
//                println("Retrieving Roll Call with \(self.rollCallUserArray!.count)")
//                
//                if let usersPresent = usersPresent as? [PFObject] {
//                    for rollCallUserArray in usersPresent {
//                        println(userPresent.username)
//                    }
//                }
//            } else {
//                // Log details of the failure
//                println("Error: \(error!) \(error!.userInfo!)")
//            }
//        }
    }
    
    //- (void)fetchLogItems {
    //    PFQuery *logItemQuery = [PFQuery queryWithClassName:@"MaintenanceLog"];
    //    [logItemQuery addAscendingOrder:@"dataSent"];
    //    [logItemQuery setLimit:1000];
    //    [logItemQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    //        NSLog(@"Got: %li", objects.count);
    //        for (PFObject *logItem in objects) {
    //            NSLog(@"Name: %@ Email:%@",[logItem objectForKey:@"username"], [logItem objectForKey:@"email"]);
    //        }
    //    }];
    //}
    
    
    // MARK : TableView Methods
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rollCallUserArray!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        let currentPerson = rollCallUserArray![indexPath.row]
        cell.textLabel!.text = currentPerson.username
        let isInBuilding = currentPerson["isInBuilding"]! as! Bool
        if isInBuilding {
            cell.backgroundColor = UIColor.greenColor()
        } else {
            cell.backgroundColor = UIColor.redColor()
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // add code to not highlight selected row
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        rollCallTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        fetchRollCallUsers()
        rollCallTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
