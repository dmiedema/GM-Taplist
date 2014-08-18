//
//  Beer.swift
//  GM Taplist
//
//  Created by Daniel Miedema on 8/17/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

import Foundation
import CoreData

class Beer: NSManagedObject {

    @NSManaged var abv: NSNumber
    @NSManaged var amount: NSNumber
    @NSManaged var favorite: NSNumber
    @NSManaged var growler_price: NSDecimalNumber
    @NSManaged var growlette_price: NSDecimalNumber
    @NSManaged var halfpint_price: NSDecimalNumber
    @NSManaged var ibu: NSNumber
    @NSManaged var id: NSNumber
    @NSManaged var name: String
    @NSManaged var pint_price: NSDecimalNumber
    @NSManaged var purchased: NSNumber
    @NSManaged var style: String
    @NSManaged var tap_id: NSNumber
    @NSManaged var brewery: Brewery
    @NSManaged var review: Review

}
