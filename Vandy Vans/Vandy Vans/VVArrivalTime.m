//
//  VVArrivalTime.m
//  Vandy Vans
//
//  Created by Seth Friedman on 11/24/12.
//  Copyright (c) 2012 VandyApps. All rights reserved.
//

#import "VVArrivalTime.h"
#import "VVSyncromaticsClient.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "VVRoute.h"
#import "VVStop.h"
#import "VVVan.h"

@implementation VVArrivalTime

#pragma mark - Designated Initializer

- (instancetype)initWithStop:(VVStop *)stop route:(VVRoute *)route andArrivalTimeInMinutes:(NSNumber *)arrivalTimeInMinutes {
    self = [super init];
    
    if (self) {
        _stop = stop;
        _route = route;
        _arrivalTimeInMinutes = arrivalTimeInMinutes;
    }
    
    return self;
}

#pragma mark - Factory Method

+ (instancetype)arrivalTimeWithStop:(VVStop *)stop route:(VVRoute *)route andArrivalTimeInMinutes:(NSNumber *)arrivalTimeInMinutes {
    return [[self alloc] initWithStop:stop
                                route:route
              andArrivalTimeInMinutes:arrivalTimeInMinutes];
}

#pragma mark - NSObject

- (NSString *)description {
    return [NSString stringWithFormat:@"Stop: %@\nRoute: %@\nArrival Time: %@ minutes", self.stop, self.route, self.arrivalTimeInMinutes];
}

- (BOOL)isEqual:(id)object {
    VVArrivalTime *otherArrivalTime = object;
    
    // TODO - Implement this method for Stop and Route classes
    return [self.stop isEqual:otherArrivalTime.stop] && [self.route isEqual:otherArrivalTime.route] && [self.arrivalTimeInMinutes isEqualToNumber:otherArrivalTime.arrivalTimeInMinutes];
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

+ (void)arrivalTimesForStop:(VVStop *)stop withBlock:(void (^)(NSArray *))block {
    [[VVSyncromaticsClient sharedClient] fetchArrivalTimesForStop:stop
                                              withCompletionBlock:block];
}

@end
