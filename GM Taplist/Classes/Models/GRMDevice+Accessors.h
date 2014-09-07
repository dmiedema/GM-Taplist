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
+ (instancetype)createOrUpdate:(NSDictionary *)data inManagedObjectContext:(NSManagedObjectContext *)context;

/*!
 
 */
+ (instancetype)loadObjectID:(NSInteger)obj_ID inManagedObjectContext:(NSManagedObjectContext *)context;

/*!
 
 */
+ (instancetype)loadObjectByToken:(NSString *)token inManagedObjectContext:(NSManagedObjectContext *)context;
@end
