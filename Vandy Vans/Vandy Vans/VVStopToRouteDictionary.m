//
//  VVStopToRouteDictionary.m
//  Vandy Vans
//
//  Created by Seth Friedman on 3/27/14.
//  Copyright (c) 2014 VandyApps. All rights reserved.
//

#import "VVStopToRouteDictionary.h"
#import "VVRouteDictionary.h"

@implementation VVStopToRouteDictionary

+ (NSDictionary *)sharedDictionary {
    static NSDictionary *_sharedDictionary;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        VVRoute *blueRoute = [VVRouteDictionary routeForName:@"Blue"];
        VVRoute *redRoute = [VVRouteDictionary routeForName:@"Red"];
        VVRoute *greenRoute = [VVRouteDictionary routeForName:@"Green"];
        
        NSArray *allRoutes = @[blueRoute, redRoute, greenRoute];
        NSArray *blueAndGreenRoutes = @[blueRoute, greenRoute];
        NSArray *redAndGreenRoutes = @[redRoute, greenRoute];
        NSArray *redRouteArray = @[redRoute];
        NSArray *greenRouteArray = @[greenRoute];
        
        _sharedDictionary = @{@"Branscomb Quad": allRoutes,
                              @"Carmichael Towers": allRoutes,
                              @"Murray House": allRoutes,
                              @"Highland Quad": allRoutes,
                              @"Vanderbilt Police Department": redAndGreenRoutes,
                              @"Vanderbilt Book Store": greenRouteArray,
                              @"Kissam Quad": blueAndGreenRoutes,
                              @"Terrace Place Garage": greenRouteArray,
                              @"North House": redRouteArray,
                              @"Blair School of Music": greenRouteArray,
                              @"McGugin Center": greenRouteArray,
                              @"Blakemore House": greenRouteArray,
                              @"Medical Center": redRouteArray};
    });
    
    return _sharedDictionary;
}

+ (NSArray *)routesForStopName:(NSString *)name {
    return [self sharedDictionary][name];
}

@end
