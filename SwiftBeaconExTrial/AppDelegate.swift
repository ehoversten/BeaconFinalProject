//
//  AppDelegate.swift
//  SwiftBeaconExTrial
//
//  Created by Erik Hoversten on 06.08.15.
//  Copyright (c) 2015 EverProductions. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    var locationManager: CLLocationManager?
    var lastProximity: CLProximity?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        let uuidString = "B9407F30-F5F8-466E-AFF9-25556B57FE6D"
        let beaconUUID = NSUUID(UUIDString: uuidString)
        
        // Purple Beacon
        let beacon_1_major: CLBeaconMajorValue = 22793
        let beacon_1_minor: CLBeaconMinorValue = 6886
        let beacon_1_Identifier = "FrontEndRoom"
        
        // Ice Blue Beacon
        let beacon_2_major: CLBeaconMajorValue = 44127
        let beacon_2_minor: CLBeaconMinorValue = 8760
        let beacon_2_Identifier = "RubyRoom"
        
        // Mint Green Beacon
        let beacon_3_major: CLBeaconMajorValue = 29038
        let beacon_3_minor: CLBeaconMinorValue = 35386
        let beacon_3_Identifier = "iOSRoom"
        
        
        
        // Purple Beacon Region
        let purpleBeaconRegion: CLBeaconRegion = CLBeaconRegion(proximityUUID: beaconUUID, major: beacon_1_major, minor:beacon_1_minor , identifier: beacon_1_Identifier)
        
        // Blue Beacon Region
        let blueBeaconRegion: CLBeaconRegion = CLBeaconRegion(proximityUUID: beaconUUID, major: beacon_2_major, minor: beacon_2_minor, identifier: beacon_2_Identifier)
        
        // Green Beacon Region
        let greenBeaconRegion: CLBeaconRegion = CLBeaconRegion(proximityUUID: beaconUUID, major: beacon_3_major, minor: beacon_3_minor, identifier: beacon_3_Identifier)
        
        self.locationManager = CLLocationManager()
        if(locationManager!.respondsToSelector("requestAlwaysAuthorization"))   {
            locationManager!.requestAlwaysAuthorization()
        }
        locationManager!.delegate = self
        locationManager!.pausesLocationUpdatesAutomatically = false
        
        // Start monitoring/ranging for Purple beacon
        locationManager!.startMonitoringForRegion(purpleBeaconRegion)
        locationManager!.startRangingBeaconsInRegion(purpleBeaconRegion)
//        locationManager!.startUpdatingLocation()
        
        // Start monitoring/ranging for Blue beacon
        locationManager!.startMonitoringForRegion(blueBeaconRegion)
        locationManager!.startRangingBeaconsInRegion(blueBeaconRegion)
//        locationManager!.startUpdatingLocation()
        
        // Start monitoring/ranging for Green beacon
        locationManager!.startMonitoringForRegion(greenBeaconRegion)
        locationManager!.startRangingBeaconsInRegion(greenBeaconRegion)
        
        // Start updating location for all beacon regions
        locationManager!.startUpdatingLocation()
        
        
        if(application.respondsToSelector("registerUserNotificationSettings:")) {
            application.registerUserNotificationSettings(
                UIUserNotificationSettings(
                    forTypes: UIUserNotificationType.Alert | UIUserNotificationType.Sound,
                    categories: nil))
        }
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension AppDelegate: CLLocationManagerDelegate  {
    func sendLocalNotificationWithMessage(message: String!)  {
        let notification = UILocalNotification()
        notification.alertBody = message
        notification.soundName = UILocalNotificationDefaultSoundName;
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
//        println("didRangeBeacons \(beacons.count)")

        if (beacons.count > 0) {
            let nearestBeacon: CLBeacon = beacons[0] as! CLBeacon
            
            if(nearestBeacon.proximity == lastProximity || nearestBeacon.proximity == CLProximity.Unknown) {
                return
            }
            lastProximity = nearestBeacon.proximity
            
            switch nearestBeacon.proximity  {
            case CLProximity.Immediate:
              //  if (self.lastProximity != CLProximity.Immediate)  {
                println("You are in the immediate proximity of \(region.identifier) beacon")
                NSNotificationCenter.defaultCenter().postNotificationName("\(region.identifier)Immediate", object: self)
               // }
            case CLProximity.Near:
              //  if (self.lastProximity != proximity)  {
                println("You are near \(region.identifier) beacon")
                NSNotificationCenter.defaultCenter().postNotificationName("\(region.identifier)Near", object: self)
              //  }
            case CLProximity.Far:
              //  if (self.lastProximity != proximity)  {
                println("You are far away from \(region.identifier) beacon")
              //  }
            case CLProximity.Unknown:
                return
            }
            // self.lastProximity = ?
        } else {
//            message = "No \(region.identifier) beacons nearby"
        }
        
//        sendLocalNotificationWithMessage(message)
    }
    
//    func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!) {
//        manager.startRangingBeaconsInRegion(region as! CLBeaconRegion)
//        manager.startUpdatingLocation()
//        let notification = UILocalNotification()
//        println("You have entered the Beacon Region")
//        sendLocalNotificationWithMessage("You entered the Beacon Region")
//        notification.soundName = UILocalNotificationDefaultSoundName;
//        
//    }
//    
//    func locationManager(manager: CLLocationManager!, didExitRegion region: CLRegion!) {
//        manager.stopRangingBeaconsInRegion(region as! CLBeaconRegion)
//        manager.stopUpdatingLocation()
//        println("You have exited the Beacon Region")
//        sendLocalNotificationWithMessage("You have exited the Beacon Region")
//    }
    

    
    
}








