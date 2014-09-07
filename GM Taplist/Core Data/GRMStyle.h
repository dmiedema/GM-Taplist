//
//  GRMStyle.h
//  GM Taplist
//
//  Created by Daniel Miedema on 9/7/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "GRMBaseObject.h"

@class GRMBeer;

@interface GRMStyle : GRMBaseObject

@property (nonatomic, retain) NSString * style;
@property (nonatomic, retain) NSNumber * style_id;
@property (nonatomic, retain) GRMBeer *beer;

@end
