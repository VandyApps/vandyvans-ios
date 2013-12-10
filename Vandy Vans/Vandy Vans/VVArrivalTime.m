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
#import "VVRoute.h"

@implementation VVArrivalTime

@synthesize stopName = _stopName;
@synthesize arrivalTimeInMinutes = _arrivalTimeInMinutes;

#pragma mark - Designated Initializer

- (instancetype)initWithStopName:(NSString *)stopName routeName:(NSString *)routeName andArrivalTimeInMinutes:(NSNumber *)arrivalTimeInMinutes {
    self = [super init];
    
    if (self) {
        _stopName = stopName;
        _routeName = routeName;
        _arrivalTimeInMinutes = arrivalTimeInMinutes;
    }
    
    return self;
}

- (id)initWithAttributes:(NSDictionary*)attributes {
    self = [super init];
    if (self) {
        _stopName = [attributes objectForKey:@"StopName"];
        _routeName = [attributes objectForKey:@"RouteName"];
        _arrivalTimeInMinutes = [attributes objectForKey:@"ArrivalTimeInMinutes"];
    }
    
    return self;
}

#pragma mark - NSObject

- (NSString *)description {
    return [NSString stringWithFormat:@"Stop Name: %@\nRoute Name: %@\nArrival Time: %@ minutes", self.stopName, self.routeName, self.arrivalTimeInMinutes];
}

- (BOOL)isEqual:(id)object {
    VVArrivalTime *otherArrivalTime = object;
    
    return [self.stopName isEqualToString:otherArrivalTime.stopName] && [self.routeName isEqualToString:otherArrivalTime.routeName] && [self.arrivalTimeInMinutes isEqualToNumber:otherArrivalTime.arrivalTimeInMinutes];
}

#pragma mark - Class Methods

+ (BOOL)isStopForAllRoutes:(NSString *)stopName __attribute__((pure)) {
    return ([stopName isEqualToString:@"Branscomb Quad"] || [stopName isEqualToString:@"Carmichael Towers"] ||
      [stopName isEqualToString:@"Murray House"] || [stopName isEqualToString:@"Highland Quad"]);
}

+ (BOOL)isStopForGreenRouteButNotAllRoutes:(NSString *)stopName __attribute__((pure)) {
    return ([stopName isEqualToString:@"Vanderbilt Police Department"] || [stopName isEqualToString:@"Vanderbilt Book Store"] ||
      [stopName isEqualToString:@"Kissam Quad"] || [stopName isEqualToString:@"Terrace Place Garage"] ||
      [stopName isEqualToString:@"Wesley Place Garage"] || [stopName isEqualToString:@"Blair School of Music"] ||
      [stopName isEqualToString:@"McGugin Center"] || [stopName isEqualToString:@"Blakemore House"]);
}

+ (BOOL)isStopForBlueRouteButNotAllRoutes:(NSString *)stopName __attribute__((pure)) {
    return [stopName isEqualToString:@"Kissam Quad"];
}

// The four possible scenarios for this method are that stops are either on all routes, on just the Green Route, on the Green and Blue Routes, or on just the Red Route.
/*+ (void)arrivalTimesForStopID:(NSUInteger)stopID stopName:(NSString *)stopName withBlock:(void (^)(NSArray *arrivalTimesArray))block {
    NSDictionary *params = @{@"api_key" : [VVAPIClient apiKey]};
    
    __block NSMutableOrderedSet *arrivalTimesSet = [[NSMutableOrderedSet alloc] init];
    
    NSComparator arrivalTimesComparator = ^NSComparisonResult(id obj1, id obj2) {
        VVArrivalTime *arrivalTime1 = (VVArrivalTime *)obj1;
        VVArrivalTime *arrivalTime2 = (VVArrivalTime *)obj2;
        
        return [arrivalTime1.arrivalTimeInMinutes compare:arrivalTime2.arrivalTimeInMinutes];
    };
    
    __block AFJSONRequestOperation *blueRouteArrivalTimeRequestOperation;
    __block AFJSONRequestOperation *greenRouteArrivalTimeRequestOperation;
    __block AFJSONRequestOperation *redRouteArrivalTimeRequestOperation;
    
    NSMutableArray *requestOperations = [[NSMutableArray alloc] init];
    
    if ([self isStopForAllRoutes:stopName]) {
        blueRouteArrivalTimeRequestOperation = [self arrivalTimeRequestOperationForRouteName:@"Blue" stopName:stopName stopID:stopID params:params];
        greenRouteArrivalTimeRequestOperation = [self arrivalTimeRequestOperationForRouteName:@"Green" stopName:stopName stopID:stopID params:params];
        redRouteArrivalTimeRequestOperation = [self arrivalTimeRequestOperationForRouteName:@"Red" stopName:stopName stopID:stopID params:params];
        
        [requestOperations addObject:blueRouteArrivalTimeRequestOperation];
        [requestOperations addObject:greenRouteArrivalTimeRequestOperation];
        [requestOperations addObject:redRouteArrivalTimeRequestOperation];
    } else if ([self isStopForGreenRouteButNotAllRoutes:stopName]) {
        greenRouteArrivalTimeRequestOperation = [self arrivalTimeRequestOperationForRouteName:@"Green" stopName:stopName stopID:stopID params:params];
        [requestOperations addObject:greenRouteArrivalTimeRequestOperation];
        
        if ([self isStopForBlueRouteButNotAllRoutes:stopName]) {
            blueRouteArrivalTimeRequestOperation = [self arrivalTimeRequestOperationForRouteName:@"Blue" stopName:stopName stopID:stopID params:params];
            [requestOperations addObject:blueRouteArrivalTimeRequestOperation];
        }
    } else { // The stop is only on the Red Route.
        redRouteArrivalTimeRequestOperation = [self arrivalTimeRequestOperationForRouteName:@"Red" stopName:stopName stopID:stopID params:params];
        [requestOperations addObject:redRouteArrivalTimeRequestOperation];
    }
    
    [[VVAPIClient sharedClient] enqueueBatchOfHTTPRequestOperations:requestOperations progressBlock:nil completionBlock:^(NSArray *operations) {
        // TODO - This can probably be done faster by using GCD and putting this all on another thread. According to the AFHTTPClient source,
        // the `completionBlock` is run on the main thread.
        if ([self isStopForAllRoutes:stopName]) {
            blueRouteArrivalTimeRequestOperation = operations[0];
            greenRouteArrivalTimeRequestOperation = operations[1];
            redRouteArrivalTimeRequestOperation = operations[2];
        } else if ([self isStopForGreenRouteButNotAllRoutes:stopName]) {
            greenRouteArrivalTimeRequestOperation = operations[0];
            
            if ([self isStopForBlueRouteButNotAllRoutes:stopName]) {
                blueRouteArrivalTimeRequestOperation = operations[1];
            }
        } else { // The stop is only on the Red Route.
            redRouteArrivalTimeRequestOperation = operations[0];
        }
        
        [self addArrivalTimeFromOperation:blueRouteArrivalTimeRequestOperation withStopName:stopName andRouteName:@"Blue" toArrivalTimesSet:arrivalTimesSet];
        [self addArrivalTimeFromOperation:greenRouteArrivalTimeRequestOperation withStopName:stopName andRouteName:@"Green" toArrivalTimesSet:arrivalTimesSet];
        [self addArrivalTimeFromOperation:redRouteArrivalTimeRequestOperation withStopName:stopName andRouteName:@"Red" toArrivalTimesSet:arrivalTimesSet];
        
        if (block) {
            block([arrivalTimesSet sortedArrayUsingComparator:arrivalTimesComparator]);
        }
    }];
}*/

/*+ (void)addArrivalTimeFromOperation:(AFJSONRequestOperation *)operation withStopName:(NSString *)stopName andRouteName:(NSString *)routeName toArrivalTimesSet:(NSMutableOrderedSet *)arrivalTimesSet {
    // The code below uses `@autoreleasepool` to more quickly clean up the large amount of `NSDictionary`s created for
    // each set of arrival time predictions.
    
    [[operation.responseJSON objectForKey:@"Predictions"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        @autoreleasepool {
            NSDictionary *predictions = obj;
            NSDictionary *arrivalTimeAttributes = @{@"StopName" : stopName, @"RouteName" : routeName, @"ArrivalTimeInMinutes" : predictions[@"Minutes"]};
            
            [arrivalTimesSet addObject:[[VVArrivalTime alloc] initWithAttributes:arrivalTimeAttributes]];
        }
    }];
}*/

/*+ (AFJS *)arrivalTimeRequestOperationForRouteName:(NSString *)routeName stopName:(NSString *)stopName stopID:(NSUInteger)stopID params:(NSDictionary *)params {
    NSString *path = [[[[@"Route/" stringByAppendingFormat:@"%li", (long)[VVRoute routeIDForRouteColor:[VVRoute routeColorForRouteName:routeName]]] stringByAppendingString:@"/Stop/"] stringByAppendingFormat:@"%i", stopID] stringByAppendingString:@"/Arrivals"];
    NSMutableURLRequest *URLRequest = [[VVAPIClient sharedClient] requestWithMethod:@"GET" path:path parameters:params];
    return [AFJSONRequestOperation JSONRequestOperationWithRequest:URLRequest success:nil failure:nil];
}*/

@end
