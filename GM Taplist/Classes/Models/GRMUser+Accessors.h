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
+ (instancetype)createOrUpdate:(NSDictionary *)data inContext:(NSManagedObjectContext *)context;

/*!
 
 */
+ (instancetype)loadObjectID:(NSInteger)obj_ID inContext:(NSManagedObjectContext *)context;

/*!
 */
+ (NSArray *)devicesForUserID:(NSInteger)userID inContext:(NSManagedObjectContext *)context;
@end
