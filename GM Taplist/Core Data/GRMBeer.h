//
//  GRMBeer.h
//  GM Taplist
//
//  Created by Daniel Miedema on 9/7/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "GRMBaseObject.h"

@class GRMBrewery, GRMReview, GRMStyle;

@interface GRMBeer : GRMBaseObject

@property (nonatomic, retain) NSNumber * abv;
@property (nonatomic, retain) NSNumber * amount;
@property (nonatomic, retain) NSString * beer_description;
@property (nonatomic, retain) NSNumber * beer_id;
@property (nonatomic, retain) NSNumber * favorite;
@property (nonatomic, retain) NSDecimalNumber * growler_price;
@property (nonatomic, retain) NSDecimalNumber * growlette_price;
@property (nonatomic, retain) NSDecimalNumber * halfpint_price;
@property (nonatomic, retain) NSNumber * ibu;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDecimalNumber * pint_price;
@property (nonatomic, retain) NSNumber * purchased;
@property (nonatomic, retain) NSNumber * tap_id;
@property (nonatomic, retain) GRMBrewery *brewery;
@property (nonatomic, retain) GRMReview *review;
@property (nonatomic, retain) GRMStyle *style;

@end
