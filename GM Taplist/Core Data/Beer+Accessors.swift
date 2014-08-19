//
//  Beer+Accessors.swift
//  GM Taplist
//
//  Created by Daniel Miedema on 8/17/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

import Foundation

extension Beer {
    class func createOrUpdate(data: NSDictionary, inManagedObjectContext managedObjectContext: NSManagedObjectContext) -> Beer {
        
        var beer = Beer.loadBeerByID(data["brewsID"] as Int, inContext: managedObjectContext)
        
        if beer == nil {
            beer = NSEntityDescription.insertNewObjectForEntityForName(GrowlMovement.GMTaplist.CoreData.ObjectEntityNames.Beer, inManagedObjectContext: managedObjectContext) as? Beer
            beer?.id = data["brewsID"] as NSNumber
        }
        
        if let abv: AnyObject! = ObjectOrNull(data["BrewABV"]) {
            beer?.abv = abv as NSNumber
        } else {
            beer?.abv = 0
        }
        
        beer?.favorite = false
        
        if let growler: AnyObject! = ObjectOrNull(data["BrewABV"]) {
            beer?.growler_price =
        } else {
            
        }
        
        if let growlette: AnyObject! = ObjectOrNull(data["BrewABV"]) {
            
        } else {
            
        }
        
        if let halfPint: AnyObject! = ObjectOrNull(data["BrewABV"]) {
            
        } else {
            
        }
        
        if let ibu: AnyObject! = ObjectOrNull(data["BrewIBU"]) {
            
        } else {
            
        }
        
        if let name: AnyObject! = ObjectOrNull(data["BrewName"]) {
            
        } else {
            
        }
        
        if let pint: AnyObject! = ObjectOrNull(data["BrewABV"]) {
            
        } else {
            
        }
        
        beer?.purchased = false
        
        if let style: AnyObject! = ObjectOrNull(data["BrewABV"]) {
            
        } else {
            
        }
        
        if let tapID: AnyObject! = ObjectOrNull(data["BrewABV"]) {
            
        } else {
            
        }
        
        if let brewery: AnyObject! = ObjectOrNull(data["brewery"]) {
            
        }
        
        if let style: AnyObject! = ObjectOrNull(data["style"]) {
            
        }
        
        return beer!
    }
    
    class func loadBeerByID(id: Int, inContext context: NSManagedObjectContext) -> Beer? {
        
        let fetchRequest = NSFetchRequest(entityName: GrowlMovement.GMTaplist.CoreData.ObjectEntityNames.Beer)
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)
        
        var err: NSError?
        let results = context.executeFetchRequest(fetchRequest, error: &err) as NSArray
        
        if let error = err {
            return nil
        }
        
        return results.lastObject as? Beer
    }
}