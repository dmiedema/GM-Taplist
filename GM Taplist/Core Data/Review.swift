//
//  Review.swift
//  GM Taplist
//
//  Created by Daniel on 8/20/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

import Foundation
import CoreData

class Review: NSManagedObject {

    @NSManaged var rating: NSNumber
    @NSManaged var text: String
    @NSManaged var beer: Beer
    @NSManaged var user: User

}
