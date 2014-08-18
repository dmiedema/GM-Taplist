//
//  Store.swift
//  GM Taplist
//
//  Created by Daniel Miedema on 8/17/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

import Foundation
import CoreData

class Store: NSManagedObject {

    @NSManaged var id: NSNumber
    @NSManaged var postal_code: String
    @NSManaged var number_of_taps: NSNumber
    @NSManaged var phone: String
    @NSManaged var nearby: String
    @NSManaged var name: String
    @NSManaged var latitude: NSNumber
    @NSManaged var longitude: NSNumber
    @NSManaged var ip_address: String
    @NSManaged var active: NSNumber
    @NSManaged var address: String
    @NSManaged var city: String
    @NSManaged var state: String
    @NSManaged var hours: String

}
