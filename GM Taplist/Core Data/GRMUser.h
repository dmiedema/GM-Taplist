//
//  GRMUser.h
//  GM Taplist
//
//  Created by Daniel Miedema on 9/7/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "GRMBaseObject.h"

@class GRMDevice, GRMReview;

@interface GRMUser : GRMBaseObject

@property (nonatomic, retain) NSData * avatar;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * udid;
@property (nonatomic, retain) NSNumber * user_id;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSSet *devices;
@property (nonatomic, retain) NSSet *review;
@end

@interface GRMUser (CoreDataGeneratedAccessors)

- (void)addDevicesObject:(GRMDevice *)value;
- (void)removeDevicesObject:(GRMDevice *)value;
- (void)addDevices:(NSSet *)values;
- (void)removeDevices:(NSSet *)values;

- (void)addReviewObject:(GRMReview *)value;
- (void)removeReviewObject:(GRMReview *)value;
- (void)addReview:(NSSet *)values;
- (void)removeReview:(NSSet *)values;

@end
