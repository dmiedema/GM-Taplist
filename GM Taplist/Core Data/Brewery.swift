//
//  Brewery.swift
//  GM Taplist
//
//  Created by Daniel Miedema on 8/17/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

import Foundation
import CoreData

class Brewery: NSManagedObject {

    @NSManaged var avatar: NSData
    @NSManaged var city: String
    @NSManaged var id: NSNumber
    @NSManaged var name: String
    @NSManaged var state: String
    @NSManaged var beers: NSSet

}
