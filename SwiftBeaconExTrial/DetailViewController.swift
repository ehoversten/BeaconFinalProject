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
    
    var currentCourse : Course!   // of type Course (object)
    @IBOutlet var bioButton : UIButton!
    @IBOutlet var courseLabel : UILabel!
    @IBOutlet var topicTableView : UITableView!
    @IBOutlet var courseImageView : UIImageView!
    @IBOutlet var instructorImageView : UIImageView!
    
    
    // MARK - TableView Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentCourse.courseTopicArray.count

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel!.textColor = UIColor.whiteColor()

        cell.textLabel!.text = currentCourse.courseTopicArray[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 34.0
    }

//    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//        cell.backgroundColor = UIColor.clearColor()
//        cell.contentView.backgroundColor = UIColor.clearColor()
//        var bgView = UIView(frame: CGRect.zeroRect)
//        bgView.backgroundColor = UIColor.clearColor()
//        cell.backgroundView = bgView
//    }
    
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
        topicTableView.backgroundView = UIView.new()
        topicTableView.backgroundView?.backgroundColor = UIColor.clearColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        courseLabel.text = currentCourse.courseName
        courseImageView.image = UIImage(named: currentCourse.courseImageFilename)
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: currentCourse.courseBackgroundFilename)!)
        instructorImageView.image = UIImage(named: currentCourse.instructorImageFilename)
        topicTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
