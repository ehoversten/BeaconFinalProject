//
//  DetailTableViewController.swift
//  SwiftBeaconExTrial
//
//  Created by Erik Hoversten on 10.08.15.
//  Copyright (c) 2015 EverProductions. All rights reserved.
//

import UIKit

var bioArray : [Course]!


class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var currentCourse :Course!   // of type Course (object)
    @IBOutlet var bioButton : UIButton!
    @IBOutlet var courseLabel : UILabel!
    @IBOutlet var topicTableView : UITableView!
    @IBOutlet var courseImageView : UIImageView!
    
    
    // MARK - TableView Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentCourse.courseTopicArray.count

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        cell.textLabel!.text = currentCourse.courseTopicArray[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // add code to not highlight selected row
    }
    
    
    // MARK - Interactivity Methods
    
    @IBAction func bioButtonPressed(sender: UIButton)   {
        println("Bio Pressed")
        performSegueWithIdentifier("bioSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destController = segue.destinationViewController as! BioViewController
        destController.currentBio = currentCourse
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        topicTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        courseLabel.text = currentCourse.courseName
        courseImageView.image = UIImage(named: currentCourse.courseImageFilename)
        topicTableView.reloadData()
//        bioButton.imageForState(currentCourse.instructorImageFilename)
//        bioButton.textInputContextIdentifier = currentCourse.instructorName
//        bioButton.imageView = UIImage(named: currentCourse.instructorImageFilename)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
