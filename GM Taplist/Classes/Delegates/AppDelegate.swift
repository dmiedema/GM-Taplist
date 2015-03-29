//
//  AppDelegate.swift
//  GM Taplist
//
//  Created by Daniel Miedema on 8/17/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?
    var dataStack: DATAStack {
        return GrowlMovement.CoreData().Context
    }

    // MARK: - Application Life Cycle
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        // if we've asked about notifications before...
        
        if GRMUserDefaults.sharedInstance.askedAboutPushNotificationPermission() {
            application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: .Alert | .Badge | .Sound, categories: nil))
            application.registerForRemoteNotifications()
        }
        return true
    }

    func applicationWillTerminate(application: UIApplication) {
        self.dataStack.persistWithCompletion { () -> Void in
            
        }
    }

    // MARK: - Notifications
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        NSLog("Settings: \(notificationSettings)")
    }
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        NSLog("registered for remote notifiations")
        let token = deviceToken.description.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: "<>")).stringByReplacingOccurrencesOfString(" ", withString: "", options: nil, range: nil)
        
        NSUserDefaults.standardUserDefaults().setObject(token, forKey: GrowlMovement.GMTaplist.UserDefaults.PushTokenKey)
        NSUserDefaults.standardUserDefaults().synchronize()
        
        API.sharedInstance.registerUserWithToken(token, completionBlock: { (user) -> () in
        }, failureBlock: { (error) -> () in
        })
    }

    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
    }

    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        // Show an error
        NSLog("Failed to register for remote notifications")
    }
}
