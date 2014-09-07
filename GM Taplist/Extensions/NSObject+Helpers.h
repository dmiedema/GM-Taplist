//
//  NSObject+Helpers.h
//  GM Taplist
//
//  Created by Daniel Miedema on 9/7/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 Check if an object exists. 
 
 @abstract since @c [NSNull @c null] evaluates to true as an object, this checks if an object is @c nil or @c NSNull. If it is either, it returns @c nil. If not it just returns the object.
 
 @param obj to check if an object or @c nil/@c[NSNull @c null]
 @return obj if exists. @c nil if @c obj is @c nil/@c[NSNull @c null]
 */
id grm_ObjectOrNull(id obj);

@interface NSObject (Helpers)
/*!
 */
+ (void)registerNewDevice;
@end
