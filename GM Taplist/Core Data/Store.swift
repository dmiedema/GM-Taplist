//
//  Store.swift
//  GM Taplist
//
//  Created by Daniel Miedema on 8/29/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

import Foundation
import CoreData

class Store: BaseObject {

    @NSManaged var active: NSNumber
    @NSManaged var address: String
    @NSManaged var city: String
    @NSManaged var hours: String
    @NSManaged var id: NSNumber
    @NSManaged var ip_address: String
    @NSManaged var latitude: NSNumber
    @NSManaged var longitude: NSNumber
    @NSManaged var name: String
    @NSManaged var nearby: String
    @NSManaged var number_of_taps: NSNumber
    @NSManaged var phone: String
    @NSManaged var postal_code: String
    @NSManaged var state: String

}
