//
//  GRMStyle+Accessors.h
//  GM Taplist
//
//  Created by Daniel Miedema on 9/7/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

#import "GRMStyle.h"

@interface GRMStyle (Accessors)
/*!
 
 */
+ (instancetype)createOrUpdate:(NSDictionary *)data inManagedObjectContext:(NSManagedObjectContext *)context;

/*!
 
 */
+ (instancetype)loadObjectID:(NSInteger)obj_ID inManagedObjectContext:(NSManagedObjectContext *)context;
@end
