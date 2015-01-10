//
//  GRMDevice+Accessors.m
//  GM Taplist
//
//  Created by Daniel Miedema on 9/7/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GRMDevice+Accessors.h"
#import "NSObject+Helpers.h"

@interface GRMDevice()
+ (void)registerNewDevice;
@end

@implementation GRMDevice (Accessors)
+ (instancetype)createOrUpdate:(NSDictionary *)data inContext:(NSManagedObjectContext *)context {
    GRMDevice *device = [self loadObjectByToken:data[@"apns_push_token"] inContext:context];
    
    if (!device) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [NSObject registerNewDevice];
        });
        
        device = [NSEntityDescription insertNewObjectForEntityForName:@"Device" inManagedObjectContext:context];
        
        device.push_token = [[NSUserDefaults standardUserDefaults] stringForKey:@"com.GrowlMovement.GMTaplist.PushTokenKey"];
    }
    
    device.last_updated = [NSDate date];
    
    return device;
}

+ (instancetype)loadObjectByToken:(NSString *)token inContext:(NSManagedObjectContext *)context {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Device"];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"push_token = %@", token];
    
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
