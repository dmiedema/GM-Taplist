//
//  GRMUserDefaults.swift
//  GM Taplist
//
//  Created by Daniel Miedema on 11/27/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

import Foundation

struct GRMUserDefaultsKeys {
    static let AskedForPushNotificationPermission = "com.GrowlMovement.GMTaplist.AskedForPushNotificationPermission"
}

class GRMUserDefaults: NSUserDefaults {
    class var sharedInstance: GRMUserDefaults {
        struct Singleton {
            static let instance = GRMUserDefaults(suiteName: "group.com.growlmovement.gmtaplist.defaultgroup")
        }
        return Singleton.instance!
    }
    
    func askedAboutPushNotificationPermission() -> Bool {
        return GRMUserDefaults.sharedInstance.boolForKey(GRMUserDefaultsKeys.AskedForPushNotificationPermission)
    }
    
    func setAskedAboutPushNotificationPermission(asked: Bool) -> Bool {
        GRMUserDefaults.sharedInstance.setBool(asked, forKey: GRMUserDefaultsKeys.AskedForPushNotificationPermission)
        return GRMUserDefaults.sharedInstance.synchronize()
    }
}
