//
//  Device.swift
//  GM Taplist
//
//  Created by Daniel Miedema on 8/29/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

import Foundation
import CoreData

class Device: BaseObject {

    @NSManaged var name: String
    @NSManaged var push_token: String
    @NSManaged var user: User

}
