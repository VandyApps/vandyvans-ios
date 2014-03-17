//
//  VVStop.m
//  Vandy Vans
//
//  Created by Seth Friedman on 12/10/13.
//  Copyright (c) 2013 VandyApps. All rights reserved.
//

#import "VVStop.h"
#import "VVRoute.h"

static NSString * const kStopNamesKey = @"StopNames";

@interface VVStop ()

- (NSString *)stopNameForStopID:(NSString *)stopID;

@end

@implementation VVStop

#pragma mark - Designated Initializer

/*- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    
    if (self) {
        _name = name;
        _stopID = [self stopIDForStopName:name];
        _routes = [self routesForStopName:name];
    }
    
    return self;
}*/

- (instancetype)initWithID:(NSString *)stopID {
    self = [super init];
    
    if (self) {
        _name = [self stopNameForStopID:stopID];
        _stopID = stopID;
        _routes = [self routesForStopName:_name];
    }
    
    return self;
}

#pragma mark - Factory Method

/*+ (instancetype)stopWithName:(NSString *)name {
    return [[self alloc] initWithName:name];
}*/

+ (instancetype)stopWithID:(NSString *)stopID {
    return [[self alloc] initWithID:stopID];
}

#pragma mark - Helper Methods

/*- (NSUInteger)stopIDForStopName:(NSString *)stopName {
    NSUInteger stopID;
    
    if ([stopName isEqualToString:@"Branscomb Quad"]) {
        stopID = 263473;
    } else if ([stopName isEqualToString:@"Carmichael Towers"]) {
        stopID = 263470;
    } else if ([stopName isEqualToString:@"Murray House"]) {
        stopID = 263454;
    } else if ([stopName isEqualToString:@"Highland Quad"]) {
        stopID = 263444;
    } else if ([stopName isEqualToString:@"Vanderbilt Police Department"]) {
        stopID = 264041;
    } else if ([stopName isEqualToString:@"Vanderbilt Book Store"]) {
        stopID = 332298;
    } else if ([stopName isEqualToString:@"Kissam Quad"]) {
        stopID = 263415;
    } else if ([stopName isEqualToString:@"Terrace Place Garage"]) {
        stopID = 238083;
    } else if ([stopName isEqualToString:@"Wesley Place Garage"]) {
        stopID = 238096;
    } else if ([stopName isEqualToString:@"North House"]) {
        stopID = 263463;
    } else if ([stopName isEqualToString:@"Blair School of Music"]) {
        stopID = 264091;
    } else if ([stopName isEqualToString:@"McGugin Center"]) {
        stopID = 264101;
    } else if ([stopName isEqualToString:@"Blakemore House"]) {
        stopID = 401204;
    } else { // Medical Center
        stopID = 446923;
    }
    
    return stopID;
}*/

- (NSString *)stopNameForStopID:(NSString *)stopID {
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *stopNamesForStopIDs = [standardUserDefaults dictionaryForKey:kStopNamesKey];
    
    if (!stopNamesForStopIDs) {
        stopNamesForStopIDs = @{@"263473": @"Branscomb Quad",
                                @"263470": @"Carmichael Towers",
                                @"263454": @"Murray House",
                                @"263444": @"Highland Quad",
                                @"264041": @"Vanderbilt Police Department",
                                @"332298": @"Vanderbilt Book Store",
                                @"263415": @"Kissam Quad",
                                @"238083": @"Terrace Place Garage",
                                @"238096": @"Wesley Place Garage",
                                @"263463": @"North House",
                                @"264091": @"Blair School of Music",
                                @"264101": @"McGugin Center",
                                @"401204": @"Blakemore House",
                                @"446923": @"Medical Center"};
        
        [standardUserDefaults setObject:stopNamesForStopIDs
                                 forKey:kStopNamesKey];
        [standardUserDefaults synchronize];
    }
    
    return stopNamesForStopIDs[stopID];
}

- (NSArray *)routesForStopName:(NSString *)stopName {
    VVRoute *blueRoute = [VVRoute routeWithRouteID:@"745"];
    VVRoute *redRoute = [VVRoute routeWithRouteID:@"746"];
    VVRoute *greenRoute = [VVRoute routeWithRouteID:@"749"];
    
    NSArray *routes;
    
    if ([stopName isEqualToString:@"Branscomb Quad"]) {
        routes = @[blueRoute, redRoute, greenRoute];
    } else if ([stopName isEqualToString:@"Carmichael Towers"]) {
        routes = @[blueRoute, redRoute, greenRoute];
    } else if ([stopName isEqualToString:@"Murray House"]) {
        routes = @[blueRoute, redRoute, greenRoute];
    } else if ([stopName isEqualToString:@"Highland Quad"]) {
        routes = @[blueRoute, redRoute, greenRoute];
    } else if ([stopName isEqualToString:@"Vanderbilt Police Department"]) {
        routes = @[redRoute, greenRoute];
    } else if ([stopName isEqualToString:@"Vanderbilt Book Store"]) {
        routes = @[greenRoute];
    } else if ([stopName isEqualToString:@"Kissam Quad"]) {
        routes = @[blueRoute, greenRoute];
    } else if ([stopName isEqualToString:@"Terrace Place Garage"]) {
        routes = @[greenRoute];
    } else if ([stopName isEqualToString:@"Wesley Place Garage"]) {
        routes = @[greenRoute];
    } else if ([stopName isEqualToString:@"North House"]) {
        routes = @[redRoute];
    } else if ([stopName isEqualToString:@"Blair School of Music"]) {
        routes = @[greenRoute];
    } else if ([stopName isEqualToString:@"McGugin Center"]) {
        routes = @[greenRoute];
    } else if ([stopName isEqualToString:@"Blakemore House"]) {
        routes = @[greenRoute];
    } else { // Medical Center
        routes = @[redRoute];
    }
    
    return routes;
}

@end
