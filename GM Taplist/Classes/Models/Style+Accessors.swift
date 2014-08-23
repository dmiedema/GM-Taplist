//
//  Style+Accessors.swift
//  GM Taplist
//
//  Created by Daniel on 8/20/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

import Foundation

extension Style {
    class func createOrUpdate(data: NSDictionary, inManagedObjectContext managedObjectContext: NSManagedObjectContext) -> Style {
        var style = Style.loadStyleByID(data["stylesID"] as Int, inContext: managedObjectContext)

        if style == nil {
            style = NSEntityDescription.insertNewObjectForEntityForName(GrowlMovement.GMTaplist.CoreData.ObjectEntityNames.Style, inManagedObjectContext: managedObjectContext) as? Style
            style?.id = data["stylesID"] as NSNumber
        }

        if let name: AnyObject! = data["Style"] {
            style?.style = name as String
        } else {
            style?.style = ""
        }

        return style!
    }

    class func loadStyleByID(id: Int, inContext context: NSManagedObjectContext) -> Style? {
        let fetchRequest = NSFetchRequest(entityName: GrowlMovement.GMTaplist.CoreData.ObjectEntityNames.Style)
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)

        var err: NSError?
        let results = context.executeFetchRequest(fetchRequest, error: &err) as NSArray
        
        if let error = err {
            return nil
        }
        
        return results.lastObject as? Style
    }
}