//
//  VVArrivalTime.m
//  Vandy Vans
//
//  Created by Seth Friedman on 11/24/12.
//  Copyright (c) 2012 VandyMobile. All rights reserved.
//

#import "VVArrivalTime.h"
#import "VVAPIClient.h"
#import <SVProgressHUD/SVProgressHUD.h>

@implementation VVArrivalTime

@synthesize stopName = _stopName;
@synthesize arrivalTimeInMinutes = _arrivalTimeInMinutes;

- (id)initWithAttributes:(NSDictionary*)attributes {
    self = [super init];
    if (self) {
        _stopName = [attributes objectForKey:@"StopName"];
        _routeName = [attributes objectForKey:@"RouteName"];
        _arrivalTimeInMinutes = [attributes objectForKey:@"ArrivalTimeInMinutes"];
    }
    
    return self;
}

+ (BOOL)isStopForAllRoutes:(NSString *)stopName {
    return ([stopName isEqualToString:@"Branscomb Quad"] || [stopName isEqualToString:@"Carmichael Towers"] ||
      [stopName isEqualToString:@"Murray House"] || [stopName isEqualToString:@"Highland Quad"]);
}

+ (BOOL)isStopForGreenRouteButNotAllRoutes:(NSString *)stopName {
    return ([stopName isEqualToString:@"Vanderbilt Police Department"] || [stopName isEqualToString:@"Vanderbilt Book Store"] ||
      [stopName isEqualToString:@"Kissam Quad"] || [stopName isEqualToString:@"Terrace Place Garage"] ||
      [stopName isEqualToString:@"Wesley Place Garage"] || [stopName isEqualToString:@"Blair School of Music"] ||
      [stopName isEqualToString:@"McGugin Center"] || [stopName isEqualToString:@"Blakemore House"]);
}

+ (BOOL)isStopForBlueRouteButNotAllRoutes:(NSString *)stopName {
    return [stopName isEqualToString:@"Kissam Quad"];
}

// The four possible scenarios for this method are that stops are either on all routes, on just the Green Route, on the Green and Blue Routes, or on just the Red Route.
+ (void)arrivalTimesForStopID:(NSUInteger)stopID stopName:(NSString *)stopName withBlock:(void (^)(NSArray *arrivalTimesArray))block {
    NSDictionary *params = @{@"api_key" : @"a922a34dfb5e63ba549adbb259518909"};
    
    __block NSMutableOrderedSet *arrivalTimesSet = [[NSMutableOrderedSet alloc] init];
    
    NSComparator arrivalTimesComparator = ^NSComparisonResult(id obj1, id obj2) {
        VVArrivalTime *arrivalTime1 = (VVArrivalTime *)obj1;
        VVArrivalTime *arrivalTime2 = (VVArrivalTime *)obj2;
        
        return [arrivalTime1.arrivalTimeInMinutes compare:arrivalTime2.arrivalTimeInMinutes];
    };
    
    if ([self isStopForAllRoutes:stopName]) {
        [self addBlueRouteArrivalTimesToArrivalTimes:arrivalTimesSet withStopName:stopName stopID:stopID params:params andBlock:^(NSMutableOrderedSet *arrivalTimes) {
            [self addGreenRouteArrivalTimesToArrivalTimes:arrivalTimes withStopName:stopName stopID:stopID params:params andBlock:^(NSMutableOrderedSet *arrivalTimes) {
                [self addRedRouteArrivalTimesToArrivalTimes:arrivalTimes withStopName:stopName stopID:stopID params:params andBlock:^(NSMutableOrderedSet *arrivalTimes) {
                    if (block) {
                        block([arrivalTimes sortedArrayUsingComparator:arrivalTimesComparator]);
                    }
                }];
            }];
        }];
    } else if ([self isStopForGreenRouteButNotAllRoutes:stopName]) {
        [self addGreenRouteArrivalTimesToArrivalTimes:arrivalTimesSet withStopName:stopName stopID:stopID params:params andBlock:^(NSMutableOrderedSet *arrivalTimes) {
            if ([self isStopForBlueRouteButNotAllRoutes:stopName]) {
                [self addBlueRouteArrivalTimesToArrivalTimes:arrivalTimes withStopName:stopName stopID:stopID params:params andBlock:^(NSMutableOrderedSet *arrivalTimes) {
                    if (block) {
                        block([arrivalTimes sortedArrayUsingComparator:arrivalTimesComparator]);
                    }
                }];
            } else {
                if (block) {
                    block([arrivalTimes sortedArrayUsingComparator:arrivalTimesComparator]);
                }
            }
        }];
    } else { // The stop is only on the Red Route.
        [self addRedRouteArrivalTimesToArrivalTimes:arrivalTimesSet withStopName:stopName stopID:stopID params:params andBlock:^(NSMutableOrderedSet *arrivalTimes) {
            if (block) {
                block([arrivalTimes sortedArrayUsingComparator:arrivalTimesComparator]);
            }
        }];
    }
}

+ (void)addBlueRouteArrivalTimesToArrivalTimes:(NSMutableOrderedSet *)arrivalTimes withStopName:(NSString *)stopName stopID:(NSUInteger)stopID params:(NSDictionary *)params andBlock:(void (^)(NSMutableOrderedSet *arrivalTimes))block {
    __block NSDictionary *arrivalTimeAttributes;
    
    [[VVAPIClient sharedClient] getPath:[[[[@"Route/" stringByAppendingFormat:@"%i", 745] stringByAppendingString:@"/Stop/"] stringByAppendingFormat:@"%i", stopID] stringByAppendingString:@"/Arrivals"] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        for (NSDictionary *predictions in [responseObject objectForKey:@"Predictions"]) {
            arrivalTimeAttributes = @{
                @"StopName" : stopName,
                @"RouteName" : @"Blue",
                @"ArrivalTimeInMinutes" : [predictions objectForKey:@"Minutes"]
            };
            
            [arrivalTimes addObject:[[VVArrivalTime alloc] initWithAttributes:arrivalTimeAttributes]];
        }
        
        if (block) {
            block(arrivalTimes);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        if (block) {
            block(nil);
        }
    }];
}

+ (void)addGreenRouteArrivalTimesToArrivalTimes:(NSMutableOrderedSet *)arrivalTimes withStopName:(NSString *)stopName stopID:(NSUInteger)stopID params:(NSDictionary *)params andBlock:(void (^)(NSMutableOrderedSet *arrivalTimes))block {
    __block NSDictionary *arrivalTimeAttributes;
    
    [[VVAPIClient sharedClient] getPath:[[[[@"Route/" stringByAppendingFormat:@"%i", 749] stringByAppendingString:@"/Stop/"] stringByAppendingFormat:@"%i", stopID] stringByAppendingString:@"/Arrivals"] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        for (NSDictionary *predictions in [responseObject objectForKey:@"Predictions"]) {
            arrivalTimeAttributes = @{
                @"StopName" : stopName,
                @"RouteName" : @"Green",
                @"ArrivalTimeInMinutes" : [predictions objectForKey:@"Minutes"]
            };
            
            [arrivalTimes addObject:[[VVArrivalTime alloc] initWithAttributes:arrivalTimeAttributes]];
        }
        
        if (block) {
            block(arrivalTimes);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        if (block) {
            block(nil);
        }
    }];
}

+ (void)addRedRouteArrivalTimesToArrivalTimes:(NSMutableOrderedSet *)arrivalTimes withStopName:(NSString *)stopName stopID:(NSUInteger)stopID params:(NSDictionary *)params andBlock:(void (^)(NSMutableOrderedSet *arrivalTimes))block {
    __block NSDictionary *arrivalTimeAttributes;
    
    [[VVAPIClient sharedClient] getPath:[[[[@"Route/" stringByAppendingFormat:@"%i", 746] stringByAppendingString:@"/Stop/"] stringByAppendingFormat:@"%i", stopID] stringByAppendingString:@"/Arrivals"] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        for (NSDictionary *predictions in [responseObject objectForKey:@"Predictions"]) {
            arrivalTimeAttributes = @{
                @"StopName" : stopName,
                @"RouteName" : @"Red",
                @"ArrivalTimeInMinutes" : [predictions objectForKey:@"Minutes"]
            };
            
            [arrivalTimes addObject:[[VVArrivalTime alloc] initWithAttributes:arrivalTimeAttributes]];
        }
        
        if (block) {
            block(arrivalTimes);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        if (block) {
            block(nil);
        }
    }];
}

@end
