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
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
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
        var bioDestController = segue.destinationViewController as! BioViewController
        println("Bio")
        if segue.identifier == "bioFromListSegue"  {
            let indexPath = staffTableView.indexPathForSelectedRow()
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
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        staffTableView.reloadData()
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
