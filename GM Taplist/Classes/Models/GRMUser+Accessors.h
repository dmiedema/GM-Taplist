//
//  GRMUser+Accessors.h
//  GM Taplist
//
//  Created by Daniel Miedema on 9/7/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

#import "GRMUser.h"

@interface GRMUser (Accessors)
/*!
 
 */
+ (instancetype)createOrUpdate:(NSDictionary *)data inManagedObjectContext:(NSManagedObjectContext *)context;

/*!
 
 */
+ (instancetype)loadObjectID:(NSInteger)obj_ID inManagedObjectContext:(NSManagedObjectContext *)context;

/*!
 */
+ (NSArray *)devicesForUserID:(NSInteger)userID inManagedObjectContext:(NSManagedObjectContext *)context;
@end
