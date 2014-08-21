//
//  Brewery.swift
//  GM Taplist
//
//  Created by Daniel on 8/20/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

import Foundation
import CoreData

class Brewery: NSManagedObject {

    @NSManaged var logo_url: String
    @NSManaged var city: String
    @NSManaged var id: NSNumber
    @NSManaged var name: String
    @NSManaged var state: String
    @NSManaged var beers: NSSet

}
