//
//  GRMDevice+Accessors.h
//  GM Taplist
//
//  Created by Daniel Miedema on 9/7/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

#import "GRMDevice.h"

@interface GRMDevice (Accessors)
/*!
 
 */
+ (instancetype)createOrUpdate:(NSDictionary *)data inContext:(NSManagedObjectContext *)context;

/*!
 
 */
+ (instancetype)loadObjectByToken:(NSString *)token inContext:(NSManagedObjectContext *)context;
@end
