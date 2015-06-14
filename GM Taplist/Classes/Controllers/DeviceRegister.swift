//
//  DeviceRegister.swift
//  GM Taplist
//
//  Created by Daniel Miedema on 8/29/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

import Foundation

class DeviceRegister {
  class func registerNewDevice() {
    let types: UIUserNotificationType = .Badge | .Sound | .Alert

    let pushSettings = UIUserNotificationSettings(forTypes: types, categories: nil)

    UIApplication.sharedApplication().registerUserNotificationSettings(pushSettings)
    UIApplication.sharedApplication().registerForRemoteNotifications()
  }
}