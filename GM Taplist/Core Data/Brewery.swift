//
//  Brewery.swift
//  GM Taplist
//
//  Created by Daniel Miedema on 8/29/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

import Foundation
import CoreData

class Brewery: BaseObject {

    @NSManaged var city: String
    @NSManaged var id: NSNumber
    @NSManaged var logo_url: String
    @NSManaged var name: String
    @NSManaged var state: String
    @NSManaged var beers: NSSet

}
