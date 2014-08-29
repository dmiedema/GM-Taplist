//
//  Brewery+Accessors.swift
//  GM Taplist
//
//  Created by Daniel on 8/20/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

import Foundation

extension Brewery {
    class func createOrUpdate(data: NSDictionary, inManagedObjectContext managedObjectContext: NSManagedObjectContext) -> Brewery {
        var brewery = Brewery.loadBreweryByID(data["id"] as Int, inContext: managedObjectContext);

        if brewery == nil {
            brewery = NSEntityDescription.insertNewObjectForEntityForName(GrowlMovement.GMTaplist.CoreData.ObjectEntityNames.Brewery, inManagedObjectContext: managedObjectContext) as? Brewery
            brewery?.id = data["id"] as NSNumber
        }

        if let logo_url: AnyObject! = data["logo_url"] {
            brewery?.logo_url = logo_url as String
        } else {
            brewery?.logo_url = ""
        }

        if let city: AnyObject! = data["BreweryCity"] {
            brewery?.city = city as String
        } else {
            brewery?.city = ""
        }

        if let name: AnyObject! = data["BreweryName"] {
            brewery?.name = name as String
        } else {
            brewery?.name = ""
        }

        if let state: AnyObject! = data["BreweryState"] {
            brewery?.state = state as String
        } else {
            brewery?.state = ""
        }

        return brewery!
    }

    class func loadBreweryByID(id: Int, inContext context: NSManagedObjectContext) -> Brewery? {
        
        let fetchRequest = NSFetchRequest(entityName: GrowlMovement.GMTaplist.CoreData.ObjectEntityNames.Brewery)
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)

        var err: NSError?
        let results = context.executeFetchRequest(fetchRequest, error: &err) as NSArray

        if let error = err {
            return nil
        }

        return results.lastObject as? Brewery
    }
}