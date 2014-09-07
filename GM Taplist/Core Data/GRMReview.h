//
//  GRMReview.h
//  GM Taplist
//
//  Created by Daniel Miedema on 9/7/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "GRMBaseObject.h"

@class GRMBeer, GRMUser;

@interface GRMReview : GRMBaseObject

@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) GRMBeer *beer;
@property (nonatomic, retain) GRMUser *user;

@end
