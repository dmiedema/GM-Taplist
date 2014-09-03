//
//  Device+Accessors.swift
//  GM Taplist
//
//  Created by Daniel Miedema on 8/29/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

import Foundation

extension Device {
    class func createOrUpdate(data: NSDictionary, inManagedObjectContext context: NSManagedObjectContext) -> Device {

        var device = Device.loadDeviceByToken(data["apns_push_token"] as String, inContext: context)
        
        if device == nil {
            dispatch_sync(dispatch_get_main_queue()) { () -> Void in
                DeviceRegister.registerNewDevice()
            }
            device = NSEntityDescription.insertNewObjectForEntityForName(GrowlMovement.GMTaplist.CoreData.ObjectEntityNames.Device, inManagedObjectContext: context) as? Device
            device?.push_token = NSUserDefaults.standardUserDefaults().stringForKey(GrowlMovement.GMTaplist.UserDefaults.PushTokenKey)!
        }

        device?.name = UIDevice.currentDevice().name
        return device!
    }
    
    class func loadDeviceByToken(token: String, inContext context: NSManagedObjectContext) -> Device? {
        let fetchRequest = NSFetchRequest(entityName: GrowlMovement.GMTaplist.CoreData.ObjectEntityNames.Device)
        fetchRequest.predicate = NSPredicate(format: "push_token = %@", token)

        var err: NSError?
        let results = context.executeFetchRequest(fetchRequest, error: &err)
        
        if let error = err {
            return nil
        }
        
        return results?.last as? Device
    }
}