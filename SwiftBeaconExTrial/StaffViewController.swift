//
//  StaffViewController.swift
//  SwiftBeaconExTrial
//
//  Created by Erik Hoversten on 11.08.15.
//  Copyright (c) 2015 EverProductions. All rights reserved.
//

import UIKit

class StaffViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var staffArray : [Course]!
    @IBOutlet var staffTableView : UITableView!
    
    
    // MARK - TableView Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return staffArray.count
       // return courseArray.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        let selectedBio = staffArray[indexPath.row]
        cell.textLabel!.text = selectedBio.instructorName
        cell.detailTextLabel!.text = selectedBio.courseName
        cell.imageView!.image = UIImage(named: selectedBio.instructorImageFilename)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("bioFromListSegue", sender: self)
    }
    
    // MARK - Interactivity Methods
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let bioDestController = segue.destinationViewController as! BioViewController
        print("Bio")
        if segue.identifier == "bioFromListSegue"  {
            let indexPath = staffTableView.indexPathForSelectedRow
            if let unwrappedIndexPath = indexPath  {
                let selectedBio = staffArray[unwrappedIndexPath.row]
                bioDestController.currentBio = selectedBio
                staffTableView.deselectRowAtIndexPath(unwrappedIndexPath, animated: true)
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        staffTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        staffTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
