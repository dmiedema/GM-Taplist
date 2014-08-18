//
//  User.swift
//  GM Taplist
//
//  Created by Daniel Miedema on 8/17/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

import Foundation
import CoreData

class User: NSManagedObject {

    @NSManaged var avatar: NSData
    @NSManaged var email: String
    @NSManaged var id: NSNumber
    @NSManaged var udid: String
    @NSManaged var username: String
    @NSManaged var review: NSSet

}
