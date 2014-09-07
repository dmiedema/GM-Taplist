//
//  GRMStore.h
//  GM Taplist
//
//  Created by Daniel Miedema on 9/7/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "GRMBaseObject.h"


@interface GRMStore : GRMBaseObject

@property (nonatomic, retain) NSNumber * active;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * hours;
@property (nonatomic, retain) NSString * ip_address;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * nearby;
@property (nonatomic, retain) NSNumber * number_of_taps;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * postal_code;
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) NSNumber * store_id;

@end
