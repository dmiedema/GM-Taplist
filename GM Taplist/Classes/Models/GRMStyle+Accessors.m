//
//  GRMStyle+Accessors.m
//  GM Taplist
//
//  Created by Daniel Miedema on 9/7/14.
//  Copyright (c) 2014 Growl Movement. All rights reserved.
//

#import "GRMStyle+Accessors.h"
#import "NSObject+Helpers.h"

@implementation GRMStyle (Accessors)
+ (instancetype)createOrUpdate:(NSDictionary *)data inContext:(NSManagedObjectContext *)context {
    GRMStyle *style = [self loadObjectID:[data[@"id"] integerValue] inContext:context];

    if (!style) {
        style = [NSEntityDescription insertNewObjectForEntityForName:@"Style" inManagedObjectContext:context];
        style.style_id = @([data[@"id"] integerValue]);
    }
    
    style.style = grm_ObjectOrNull(data[@"Style"]) ?: style.style ?: @"";
    
    style.last_updated = [NSDate date];
    
    return style;
}

+ (instancetype)loadObjectID:(NSInteger)obj_ID inContext:(NSManagedObjectContext *)context {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Style"];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"style_id = %@", @(obj_ID)];
    
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
