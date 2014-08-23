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
        
        if let abv: AnyObject! = data["BrewABV"] {
            beer?.abv = abv as NSNumber
        } else {
            beer?.abv = 0
        }
                
        if let growler: AnyObject! = data["growler_price"] {
//            beer?.growler_price =
        } else {
            
        }
        
        if let growlette: AnyObject! = data["growlette_price"] {
            
        } else {
            
        }
        
        if let halfPint: AnyObject! = data["halfpint_price"] {
            
        } else {
            
        }
        
        if let ibu: AnyObject! = data["BrewIBU"] {
            beer?.ibu = ibu as NSNumber
        } else {
            beer?.ibu = 0
        }
        
        if let name: AnyObject! = data["BrewName"] {
            beer?.name = name as String;
        } else {
            beer?.name = "";
        }
        
        if let pint: AnyObject! = data["pint_price"] {
            
        } else {
            
        }

        if let beerDescription: AnyObject! = data["BrewDescription"] {
            beer?.beer_description = beerDescription as String
        } else {
            beer?.beer_description = ""
        }
        
        if let brewery: AnyObject! = data["brewery"] {
            beer?.brewery = Brewery.createOrUpdate(data["brewery"] as NSDictionary, inManagedObjectContext: managedObjectContext)
        }
        
        if let style: AnyObject! = data["style"] {
            beer?.style = Style.createOrUpdate(data["style"] as NSDictionary, inManagedObjectContext: managedObjectContext)
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