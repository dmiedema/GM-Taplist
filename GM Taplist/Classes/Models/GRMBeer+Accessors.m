//
//  GRMBeer+Accessors.m
//  GM Taplist
//
//  Created by Daniel Miedema on 9/7/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

#import "GRMBeer+Accessors.h"
#import "GRMBrewery+Accessors.h"
#import "GRMStyle+Accessors.h"
#import "NSObject+Helpers.h"

@implementation GRMBeer (Accessors)
+ (instancetype)createOrUpdate:(NSDictionary *)data inManagedObjectContext:(NSManagedObjectContext *)context {
    GRMBeer *beer = [self loadObjectID:[data[@"id"] integerValue] inManagedObjectContext:context];
    
    if (!beer) {
        beer = [NSEntityDescription insertNewObjectForEntityForName:@"Beer"inManagedObjectContext:context];
        beer.beer_id = @([data[@"id"] integerValue]);
    }
    
    beer.abv = @([grm_ObjectOrNull(data[@"abv"]) integerValue]) ?: @0;
    beer.growler_price = grm_ObjectOrNull(data[@"growler_price"]) ?: @0;
    beer.growlette_price = grm_ObjectOrNull(data[@"growlette_price"]) ?: @0;
    beer.pint_price = grm_ObjectOrNull(data[@"pint_price"]) ?: @0;
    beer.halfpint_price = grm_ObjectOrNull(data[@"halfpint_price"]) ?: @0;
    beer.ibu = @([grm_ObjectOrNull(data[@"BrewIBU"]) integerValue]) ?: @0;
    beer.name = grm_ObjectOrNull(data[@"BrewName"]) ?: @"";
    beer.beer_description = grm_ObjectOrNull(data[@"BrewDescription"]) ?: @"";
    
    if (grm_ObjectOrNull(data[@"brewery"])) {
        beer.brewery = [GRMBrewery createOrUpdate:data[@"brewery"] inManagedObjectContext:context];
    }
    
    if (grm_ObjectOrNull(data[@"style"])) {
        beer.style = [GRMStyle createOrUpdate:data[@"style"] inManagedObjectContext:context];
    }
    
    return beer;
}

+ (instancetype)loadObjectID:(NSInteger)obj_ID inManagedObjectContext:(NSManagedObjectContext *)context {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Beer"];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"beer_id = %@", @(obj_ID)];
    
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
