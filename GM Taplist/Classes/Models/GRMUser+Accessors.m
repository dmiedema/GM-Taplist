//
//  GRMUser+Accessors.m
//  GM Taplist
//
//  Created by Daniel Miedema on 9/7/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

#import "GRMUser+Accessors.h"
#import "NSObject+Helpers.h"

@implementation GRMUser (Accessors)

+ (instancetype)createOrUpdate:(NSDictionary *)data inContext:(NSManagedObjectContext *)context {
    GRMUser *user = [self loadObjectID:[data[@"id"] integerValue] inContext:context];
    
    if (!user) {
        user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
        user.user_id = @([data[@"id"] integerValue]);
    }
    
    user.last_updated = [NSDate date];
    
    return user;
}

+ (instancetype)loadObjectID:(NSInteger)obj_ID inContext:(NSManagedObjectContext *)context {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"user_id = %@", @(obj_ID)];
    
    NSError *error;
    NSArray *results = [context executeFetchRequest:fetchRequest error:&error];
    
    if (error || !results) {
        // Error
        NSLog(@"Error in %s", __PRETTY_FUNCTION__);
        // Verbose
        NSLog(@"%@", error);
        return nil;
    }
    return  [results lastObject];
}

+ (NSArray *)devicesForUserID:(NSInteger)userID inManagedObjectContext:(NSManagedObjectContext *)context {
    GRMUser *user = [self loadObjectID:userID inContext:context];
    if (!userID) {
        return nil;
    }
    return [user.devices allObjects];
}
@end
