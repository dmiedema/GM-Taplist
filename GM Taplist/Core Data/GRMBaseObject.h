//
//  GRMBaseObject.h
//  GM Taplist
//
//  Created by Daniel Miedema on 9/7/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface GRMBaseObject : NSManagedObject

@property (nonatomic, retain) NSDate * last_updated;

@end
