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

+ (instancetype)createOrUpdate:(NSDictionary *)data inManagedObjectContext:(NSManagedObjectContext *)context {
    GRMStore *store = [self loadObjectID:[data[@"id"] integerValue] inManagedObjectContext:context];
    
    if (!store) {
        store = [NSEntityDescription insertNewObjectForEntityForName:@"Store" inManagedObjectContext:context];
        store.store_id = @([data[@"id"] integerValue]);
    }
    
    store.address = grm_ObjectOrNull(data[@"StoreAddress"]) ?: @"";
    store.postal_code = grm_ObjectOrNull(data[@"StoreZip"]) ?: @"";
    store.number_of_taps = grm_ObjectOrNull(data[@"StoreTaps"]) ?: @0;
    store.phone = grm_ObjectOrNull(data[@"StorePhone"]) ?: @"";
    store.nearby = grm_ObjectOrNull(data[@"StoreNearby"]) ?: @"";
    store.latitude = grm_ObjectOrNull(data[@"StoreLat"]);
    store.longitude = grm_ObjectOrNull(data[@"StoreLong"]);
    store.ip_address = grm_ObjectOrNull(data[@"StoreIP"]) ?: @"";
    store.active = grm_ObjectOrNull(data[@"StoreActive"]) ?: @1;
    store.city = grm_ObjectOrNull(data[@"StoreCity"]) ?: @"";
    store.state = grm_ObjectOrNull(data[@"StoreState"]) ?: @"";
    store.hours = grm_ObjectOrNull(data[@"StoreHours"]) ?: @"";
    
    return store;
}

+ (instancetype)loadObjectID:(NSInteger)obj_ID inManagedObjectContext:(NSManagedObjectContext *)context {
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

+ (NSInteger)storeIDForName:(NSString *)name inManagedObjectContext:(NSManagedObjectContext *)context {
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
