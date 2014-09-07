//
//  GRMDevice.h
//  GM Taplist
//
//  Created by Daniel Miedema on 9/7/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "GRMBaseObject.h"

@class GRMUser;

@interface GRMDevice : GRMBaseObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * push_token;
@property (nonatomic, retain) GRMUser *user;

@end
