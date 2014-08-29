//
//  User+Accessors.swift
//  GM Taplist
//
//  Created by Daniel Miedema on 8/29/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

import Foundation

extension User {
    // MARK: Querying
    class func devicesForUser(userID: Int, inManagedObjectContext context: NSManagedObjectContext) -> [Device] {
        let currentUser = User.loadUserByID(userID, inContext: context)

        let devices = currentUser?.devices.allObjects
        return devices as [Device]
    }

    // MARK: Loading
    class func createOrUpdate(data: NSDictionary, inManagedObjectContext context: NSManagedObjectContext) -> User {
        var user = User.loadUserByID(data["id"] as Int, inContext: context)

        if user == nil {
            user = NSEntityDescription.insertNewObjectForEntityForName(GrowlMovement.GMTaplist.CoreData.ObjectEntityNames.User, inManagedObjectContext: context) as? User
            user?.id = data["id"] as NSNumber
        }

        return user!
    }

    class func loadUserByID(id: Int, inContext context: NSManagedObjectContext) -> User? {
        let fetchRequest = NSFetchRequest(entityName: GrowlMovement.GMTaplist.CoreData.ObjectEntityNames.User)
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)

        var err: NSError?
        let results = context.executeFetchRequest(fetchRequest, error: &err) as NSArray
    
        if let error = err {
            return nil
        }

        return results.lastObject as? User
    }
}