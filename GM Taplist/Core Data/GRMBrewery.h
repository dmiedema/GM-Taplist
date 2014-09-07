//
//  GRMBrewery.h
//  GM Taplist
//
//  Created by Daniel Miedema on 9/7/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "GRMBaseObject.h"

@class GRMBeer;

@interface GRMBrewery : GRMBaseObject

@property (nonatomic, retain) NSNumber * brewery_id;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * logo_url;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) NSSet *beers;
@end

@interface GRMBrewery (CoreDataGeneratedAccessors)

- (void)addBeersObject:(GRMBeer *)value;
- (void)removeBeersObject:(GRMBeer *)value;
- (void)addBeers:(NSSet *)values;
- (void)removeBeers:(NSSet *)values;

@end
