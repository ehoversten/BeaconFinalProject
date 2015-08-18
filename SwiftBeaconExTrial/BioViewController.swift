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

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        bioNameLabel.text = currentBio.instructorName
        bioImageView.image = UIImage(named: currentBio.instructorImageFilename)
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: currentBio.courseBackgroundFilename)!)
        bioCourseLabel.text = currentBio.courseName
        bioTextView.text = currentBio.instructorBio
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
