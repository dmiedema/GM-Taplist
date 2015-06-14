//
//  NSObject+Helpers.m
//  GM Taplist
//
//  Created by Daniel Miedema on 9/7/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "NSObject+Helpers.h"

id grm_ObjectOrNull(id obj) {
  if (obj == nil || [obj isEqual:[NSNull null]]) {
    return nil;
  }
  return obj;
}

@implementation NSObject (Helpers)
+ (void)registerNewDevice {
    UIUserNotificationSettings *notificationSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
}
@end
