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
+ (instancetype)createOrUpdate:(NSDictionary *)data inContext:(NSManagedObjectContext *)context {
    GRMBeer *beer = [self loadObjectID:[data[@"id"] integerValue] inContext:context];
    
    if (!beer) {
        beer = [NSEntityDescription insertNewObjectForEntityForName:@"Beer"inManagedObjectContext:context];
        beer.beer_id = @([data[@"id"] integerValue]);
    }
    
    beer.abv              = @([grm_ObjectOrNull(data[@"abv"]) integerValue])     ?: beer.abv                ?: @0;
    beer.growler_price    = grm_ObjectOrNull(data[@"growler_price"])             ?: beer.growler_price      ?: @0;
    beer.growlette_price  = grm_ObjectOrNull(data[@"growlette_price"])           ?: beer.growlette_price    ?: @0;
    beer.pint_price       = grm_ObjectOrNull(data[@"pint_price"])                ?: beer.pint_price         ?: @0;
    beer.halfpint_price   = grm_ObjectOrNull(data[@"halfpint_price"])            ?: beer.halfpint_price     ?: @0;
    beer.ibu              = @([grm_ObjectOrNull(data[@"BrewIBU"]) integerValue]) ?: beer.ibu                ?: @0;
    beer.name             = grm_ObjectOrNull(data[@"BrewName"])                  ?: beer.name               ?: @"";
    beer.beer_description = grm_ObjectOrNull(data[@"BrewDescription"])           ?: beer.beer_description   ?: @"";
    
    if (grm_ObjectOrNull(data[@"brewery"])) {
        beer.brewery = [GRMBrewery createOrUpdate:data[@"brewery"] inContext:context];
    }
    
    if (grm_ObjectOrNull(data[@"style"])) {
        beer.style = [GRMStyle createOrUpdate:data[@"style"] inContext:context];
    }
    
    beer.last_updated = [NSDate date];
    return beer;
}

+ (instancetype)loadObjectID:(NSInteger)obj_ID inContext:(NSManagedObjectContext *)context {
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
