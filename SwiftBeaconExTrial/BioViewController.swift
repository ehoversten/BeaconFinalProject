//
//  BioViewController.swift
//  SwiftBeaconExTrial
//
//  Created by Erik Hoversten on 10.08.15.
//  Copyright (c) 2015 EverProductions. All rights reserved.
//

import UIKit

class BioViewController: UIViewController, UITextViewDelegate {
    
    var currentBio : Course!
    
    @IBOutlet var bioImageView : UIImageView!
    @IBOutlet var bioNameLabel : UILabel!
    @IBOutlet var bioCourseLabel : UILabel!
    @IBOutlet var bioTextView : UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        bioNameLabel.text = currentBio.instructorName
        bioImageView.image = UIImage(named: currentBio.instructorImageFilename)
        bioCourseLabel.text = currentBio.courseName
        bioTextView.text = currentBio.instructorBio
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
