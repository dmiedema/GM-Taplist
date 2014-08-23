//
//  Store+Accessors.swift
//  GM Taplist
//
//  Created by Daniel Miedema on 8/17/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

import Foundation

extension Store {
    class func createOrUpdate(data: NSDictionary, inManagedObjectContext managedObjectContext: NSManagedObjectContext) -> Store {
        
        var store = Store.loadStoreByID(data["storesID"] as Int, inContext: managedObjectContext)
        
        if store == nil {
            store = NSEntityDescription.insertNewObjectForEntityForName(GrowlMovement.GMTaplist.CoreData.ObjectEntityNames.Store, inManagedObjectContext: managedObjectContext) as? Store
            store?.id = data["storesID"] as NSNumber
        }

        if let address: AnyObject! = data["StoreAddress"] {
            store?.address = address as String
        } else {
            store?.address = ""
        }
        
        if let postCode: AnyObject! = data["StoreZip"] {
            store?.postal_code = postCode as String
        } else {
            store?.postal_code = ""
        }
        
        if let numberOfTaps: AnyObject! = data["StoreTaps"] {
            store?.number_of_taps = numberOfTaps as NSNumber
        } else {
            store?.number_of_taps = 0
        }
        
        if let phoneNumber: AnyObject! = data["StorePhone"] {
            store?.phone = phoneNumber as String
        } else {
            store?.phone = ""
        }
        
        if let near: AnyObject! = data["StoreNearby"] {
            store?.nearby = near as String
        } else {
            store?.nearby = ""
        }
        
        if let lat: AnyObject! = data["StoreLat"] {
            store?.latitude = lat as Double
        } else {
            store?.latitude = 0
        }
        
        if let long: AnyObject! = data["StoreLong"] {
            store?.longitude = long as Double
        } else {
            store?.longitude = 0
        }
        
        if let ip: AnyObject! = data["StoreIP"] {
            store?.ip_address = ip as String
        } else {
            store?.ip_address = ""
        }
        
        if let active: AnyObject! = data["StoreActive"] {
            store?.active = active as Bool
        } else {
            store?.active = false
        }
        
        if let city: AnyObject! = data["StoreCity"] {
            store?.city = city as String
        } else {
            store?.city = ""
        }

        if let state: AnyObject! = data["StoreState"] {
            store?.state = state as String
        } else {
            store?.state = ""
        }
        
        if let hours: AnyObject! = data["StoreHours"] {
            store?.hours = hours as String
        } else {
            store?.hours = ""
        }
        
        return store!
    }
    
    class func loadStoreByID(id: Int, inContext context: NSManagedObjectContext) -> Store? {
        let fetchRequest = NSFetchRequest(entityName: GrowlMovement.GMTaplist.CoreData.ObjectEntityNames.Store)
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)
        
        var err: NSError?
        let results = context.executeFetchRequest(fetchRequest, error: &err) as NSArray
        
        if let error = err {
            return nil
        }
        
        return results.lastObject as? Store
    }
}