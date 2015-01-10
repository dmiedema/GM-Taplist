//
//  GRMStore+Accessors.m
//  GM Taplist
//
//  Created by Daniel Miedema on 9/7/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

#import "GRMStore+Accessors.h"
#import "NSObject+Helpers.h"

@implementation GRMStore (Accessors)

+ (instancetype)createOrUpdate:(NSDictionary *)data inContext:(NSManagedObjectContext *)context {
    GRMStore *store = [self loadObjectID:[data[@"id"] integerValue] inContext:context];
    
    if (!store) {
        store = [NSEntityDescription insertNewObjectForEntityForName:@"Store" inManagedObjectContext:context];
        store.store_id = @([data[@"id"] integerValue]);
    }
    
    store.address        = grm_ObjectOrNull(data[@"StoreAddress"]) ?: store.address ?: @"";
    store.postal_code    = grm_ObjectOrNull(data[@"StoreZip"]) ?: store.postal_code ?: @"";
    store.number_of_taps = grm_ObjectOrNull(data[@"StoreTaps"]) ?: store.number_of_taps ?: @0;
    store.phone          = grm_ObjectOrNull(data[@"StorePhone"]) ?: store.phone ?: @"";
    store.nearby         = grm_ObjectOrNull(data[@"StoreNearby"]) ?: store.nearby ?: @"";
    store.latitude       = grm_ObjectOrNull(data[@"StoreLat"]) ?: store.latitude;
    store.longitude      = grm_ObjectOrNull(data[@"StoreLong"]) ?: store.longitude;
    store.ip_address     = grm_ObjectOrNull(data[@"StoreIP"]) ?: store.ip_address ?: @"";
    store.active         = grm_ObjectOrNull(data[@"StoreActive"]) ?: store.active ?: @YES;
    store.city           = grm_ObjectOrNull(data[@"StoreCity"]) ?: store.city ?: @"";
    store.state          = grm_ObjectOrNull(data[@"StoreState"]) ?: store.state ?: @"";
    store.hours          = grm_ObjectOrNull(data[@"StoreHours"]) ?: store.hours ?: @"";
    
    store.last_updated = [NSDate date];
    
    return store;
}

+ (instancetype)loadObjectID:(NSInteger)obj_ID inContext:(NSManagedObjectContext *)context {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Store"];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"store_id = %@", @(obj_ID)];
    
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

+ (NSInteger)storeIDForName:(NSString *)name inContext:(NSManagedObjectContext *)context {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Store"];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"name[cd] = %@", name];
    
    NSError *error;
    NSArray *results = [context executeFetchRequest:fetchRequest error:&error];
    
    if (error || !results) {
        // Error
        NSLog(@"Error in %s", __PRETTY_FUNCTION__);
        // Verbose
        NSLog(@"%@", error);
        return 0;
    }
    GRMStore *store = [results lastObject];
    return  [store.store_id integerValue];
}
/*
 
 */
@end
