//
//  GRMBrewery+Accessors.m
//  GM Taplist
//
//  Created by Daniel Miedema on 9/7/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

#import "GRMBrewery+Accessors.h"
#import "NSObject+Helpers.h"

@implementation GRMBrewery (Accessors)

+ (instancetype)createOrUpdate:(NSDictionary *)data inContext:(NSManagedObjectContext *)context {
    GRMBrewery *brewery = [self loadObjectID:[data[@"id"] integerValue] inContext:context];
    
    if (!brewery) {
        brewery = [NSEntityDescription insertNewObjectForEntityForName:@"Brewery" inManagedObjectContext:context];
        brewery.brewery_id = @([data[@"id"] integerValue]);
    }
    
    brewery.logo_url = grm_ObjectOrNull(data[@"logo_url"])      ?: brewery.logo_url ?: @"";
    brewery.name     = grm_ObjectOrNull(data[@"BreweryName"])   ?: brewery.name     ?: @"";
    brewery.city     = grm_ObjectOrNull(data[@"BreweryCity"])   ?: brewery.city     ?: @"";
    brewery.state    = grm_ObjectOrNull(data[@"BreweryState"])  ?: brewery.state    ?: @"";
    
    brewery.last_updated = [NSDate date];
    
    return brewery;
}

+ (instancetype)loadObjectID:(NSInteger)obj_ID inContext:(NSManagedObjectContext *)context {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Brewery"];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"brewery_id = %@", @(obj_ID)];
    
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
@end
