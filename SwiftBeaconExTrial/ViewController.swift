//
//  ViewController.swift
//  SwiftBeaconExTrial
//
//  Created by Erik Hoversten on 06.08.15.
//  Copyright (c) 2015 EverProductions. All rights reserved.
//

import UIKit
import Parse
import ParseUI

let beacon_1_Identifier = "FrontEndRoom"
let beacon_2_Identifier = "RubyRoom"
let beacon_3_Identifier = "iOSRoom"


class ViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate  {
    
    var courseArray : [Course]!
    var currentRoom = ""
    var rollCallHereArray : [PFUser]?

    @IBOutlet var loginButton : UIBarButtonItem!
    @IBOutlet var presentButton : UIBarButtonItem!
    @IBOutlet var beaconLabel : UILabel!
    @IBOutlet var frontEndButton : UIButton!
    @IBOutlet var rubyButton : UIButton!
    @IBOutlet var iosButton : UIButton!
    @IBOutlet var staffButton : UIButton!
    @IBOutlet var websiteButton : UIButton!
    @IBOutlet var pictureView : UIImageView!
    @IBOutlet var rollCallButton : UIButton!
    
    
    
    
    // MARK - Beacon Ranging Methods
    
    func frontEndRoomEntered(note: NSNotification) {
        println("Welcome to the Front End Room")
        if currentRoom != "frontEndRoom" {
            currentRoom = "frontEndRoom"
            self.navigationController!.popToRootViewControllerAnimated(false)
            let notification = UILocalNotification()
            notification.soundName = UILocalNotificationDefaultSoundName;
            frontEndButtonPressed(frontEndButton)
        }
    }
    
    func rubyRoomEntered(note: NSNotification) {
        println("Welcome to the Ruby Room")
        if currentRoom != "rubyRoom" {
            currentRoom = "rubyRoom"
            self.navigationController!.popToRootViewControllerAnimated(false)
            let notification = UILocalNotification()
            notification.soundName = UILocalNotificationDefaultSoundName;
            rubyButtonPressed(rubyButton)
        }
    }
    
    func iOSRoomEntered(note: NSNotification) {
        println("Welcome to the iOS Room")
        if currentRoom != "iOSRoom" {
            currentRoom = "iOSRoom"
            self.navigationController!.popToRootViewControllerAnimated(false)
            let notification = UILocalNotification()
            notification.soundName = UILocalNotificationDefaultSoundName;
            iosButtonPressed(iosButton)
        }
    }
    
    // MARK: - Parse Login Methods
    
    @IBAction func loginBarButtonPressed(sender:UIBarButtonItem)  {
        println("Login")
        if loginButton.title == "Login"  {
            var logInController = PFLogInViewController()
            logInController.delegate = self
            var signUpController = PFSignUpViewController()
            signUpController.delegate = self
            logInController.signUpController = signUpController
            self.presentViewController(logInController, animated: true, completion: nil)
        } else {
            PFUser.logOut()
            loginButton.title = "Login"
        }
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) -> Void {
        println("Logged in")
        loginButton.title = "Log Out"
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func logInViewControllerDidCancelLogIn(logInController: PFLogInViewController) -> Void  {
        println("Login Cancelled")
        loginButton.title = "Login"
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) -> Void {
        println("Did sign up")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func signUpViewControllerDidCancelSignUp(signUpController: PFSignUpViewController) -> Void {
        println("Sign up Cancelled")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
        // MARK: - Interactivity Methods
    
    @IBAction func frontEndButtonPressed(sender: UIButton)   {
        println("Front End Button Pressed")
        performSegueWithIdentifier("frontEndSegue", sender: self)

    }
    
    @IBAction func rubyButtonPressed(sender: UIButton)  {
        println("Ruby Pressed")
        performSegueWithIdentifier("rubySegue", sender: self)
        
    }
    
    @IBAction func iosButtonPressed(sender: UIButton)   {
        println("iOS Pressed")
        performSegueWithIdentifier("iosSegue", sender: self)
    }
    
    @IBAction func staffButtonPressed(sender: UIButton)   {
        println("staff pressed")
        performSegueWithIdentifier("staffSegue", sender: self)
    }
    
//    @IBAction func rollCallButtonPressed(sender: UIButton) {
//        println("Roll Call Pressed")
//        performSegueWithIdentifier("rollCallSegue", sender: self)
//    }
    
    @IBAction func presentButtonPressed(sender: UIBarButtonItem)  {
        println("Present Button Pressed")
        performSegueWithIdentifier("rollCallSegue", sender: self)
    }
    
    @IBAction func websiteButtonPressed(sender: UIButton)    {
        println("Website Pressed")
        if let url = NSURL(string: "http://theironyard.com/locations/washington-dc/")  {
            UIApplication.sharedApplication().openURL(url)
        }
    }
  
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "staffSegue"  {
            var destController = segue.destinationViewController as! StaffViewController
            destController.staffArray = courseArray
            println("Bio")
        } else if segue.identifier == "rollCallSegue"  {
            var destController = segue.destinationViewController as! RollCallViewController
                println("Roll Call")
        } else {
            var destController = segue.destinationViewController as! DetailViewController
            
            if segue.identifier == "frontEndSegue" {
                println("FES")
                destController.currentCourse = courseArray[1]
            }
            
            if segue.identifier == "rubySegue"  {
                println("RS")
                destController.currentCourse = courseArray[2]
            }
            
            if segue.identifier == "iosSegue" {
                println("iOS")
                destController.currentCourse = courseArray[3]
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // MARK - Notifications
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"frontEndRoomEntered:" , name: "\(beacon_1_Identifier)Immediate", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"rubyRoomEntered:" , name: "\(beacon_2_Identifier)Immediate", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"iOSRoomEntered:" , name: "\(beacon_3_Identifier)Immediate", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"frontEndRoomEntered:" , name: "\(beacon_1_Identifier)Near", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"rubyRoomEntered:" , name: "\(beacon_2_Identifier)Near", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"iOSRoomEntered:" , name: "\(beacon_3_Identifier)Near", object: nil)
        
        // MARK - Array Data Methods
        
        // iOS Object Data
        let iosCourse = Course()
        iosCourse.courseBackgroundFilename = "GreenBackground4"
        iosCourse.courseName = "Mobile Engineering"
        iosCourse.courseTopicArray = ["Objective-C & C","Classes and Objects","Design fundamentals","Freelance fundamentals","MVC Fundamentals","Cocoa Design Patterns","Frameworks & Libraries","Memory Management & ARC","Core Libraries","UI Guidelines","Xcode IDE","Interface Builder","Deployment : TestFlight & App Store","Parse as a Backend","Git and GitHub","Finding a Job"]
        iosCourse.courseImageFilename = "mobile-engineering-icon"
        iosCourse.instructorImageFilename = "tom-crawford.jpg"
        iosCourse.instructorName = "Tom Crawford"
        iosCourse.instructorBio = "Tom has been involved with technology almost as long as he can remember. He's seen technologies (and computer languages) come and go from mainframes to mobile and from COBOL punch cards to Swift. While he has worked on mobile since the early days of Windows CE, he currently spends most of his time on iOS (and a little Android) with over 20 apps on the app stores for companies both large and small. He combines the technology experience with a background in business, design, and education to help his students get a well-rounded experience, not just learn to code. When he's not thinking about technology, he is an avid traveler having been to all 50 states, half of the Canadian provinces, and more than a dozen and half countries, and enjoys cooking and a nice glass of wine."
        
        
        // Campus Object Data
        let staffBio = Course()
        staffBio.courseBackgroundFilename = "GreyBackground4"
        staffBio.courseName = "Campus Director"
        staffBio.courseTopicArray = nil
        staffBio.courseImageFilename = ""
     //   staffBio.courseBackgroundFilename = ""
        staffBio.instructorImageFilename = "su-kim.jpg"
        staffBio.instructorName = "Su Kim"
        staffBio.instructorBio = "After a nomadic existence through the South, Midwest, and overseas, Su is planting roots in northern Virginia. She comes to The Iron Yard after several years of advocating for sensible immigration policy. Su is excited to show the impact that technology can have through education and see the DC campus grow in influence and support of the region. A 'non-political' political junkie, she loves all things games and DC-related shows."
        
        
        // Front End Object Data
        let frontEndCourse = Course()
        frontEndCourse.courseBackgroundFilename = "BrownBackground5"
        frontEndCourse.courseName = "Front End Engineering"
        frontEndCourse.courseTopicArray = ["HTML and CSS","Building Responsive Sites","Design fundamentals","Freelance fundamentals","JavaScript","jQuery","Underscore.js or Lo-Dash","Client-side JavaScript Frameworks","JavaScript Testing","Languages that compile to JavaScript","JavaScript Templating","Node.js Basics","Backends as a Service","Front End Tools","Git and GitHub","Finding a Job"]
        frontEndCourse.courseImageFilename = "front-end-engineering-icon"
        frontEndCourse.instructorImageFilename = "kyle-hill.jpg"
        frontEndCourse.instructorName = "Kyle Hill"
        frontEndCourse.instructorBio = "Kyle grew up on Long Island and went to college in Rhode Island, but ended up in DC several years ago trying to get some use out of his Political Science degree -- luckily for everyone, it didn't work out. He's been a developer for almost a decade, and has worked in some weird places (a healthcare company on a farm; a power supply factory; the Department of Defense) but most recently led product development at Jibe. His favorite language is Javascript, but he also has experience with Ruby, Python, C#, and MUMPS. (Yes, MUMPS is a real language. Don't use it.) Besides coding, you can usually find Kyle obsessing over board games, coffee, and a bunch of obscure foreign sports."
        
        
        // Ruby Object Data
        let rubyCourse = Course()  // create an object of type Course
        rubyCourse.courseBackgroundFilename = "RedBackground2"
        rubyCourse.courseName = "Back End Engineering"
        rubyCourse.courseTopicArray = ["Rails Fundamentals","Testing, testing, testing","Design fundamentals","Freelance fundamentals","jQuery","MVC Fundamentals","Client-side Frameworks","HTML and CSS","JavaScript Basics","CoffeeScript","Deployment","Git and GitHub","Finding a Job"]
        rubyCourse.courseImageFilename = "rails-engineering-logo"
        rubyCourse.instructorImageFilename = "james-dabbs.jpg"
        rubyCourse.instructorName = "James Dabbs"
        rubyCourse.instructorBio = "Trained as a mathematician, James heard the siren call of software development while working on his PhD, jumped ship, and never looked back. Most recently, he's been crunching numbers as a senior engineer at Emcien in Atlanta. He's very excited to be back teaching and able to share his zeal for software and development. When not thinking about code or mumbling things about monads, James is also an enthusiastic drummer - mostly math rock, naturally."
        
        courseArray = [staffBio, frontEndCourse, rubyCourse, iosCourse]   // array container to pass data

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        pictureView.image = UIImage(named: "tiy-logo")
        beaconLabel.text = "Welcome to the D.C. Campus!"
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "blueGradient2.png")!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

