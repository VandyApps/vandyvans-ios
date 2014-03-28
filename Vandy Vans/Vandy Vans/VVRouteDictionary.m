//
//  VVRoutes.m
//  Vandy Vans
//
//  Created by Seth Friedman on 3/27/14.
//  Copyright (c) 2014 VandyApps. All rights reserved.
//

#import "VVRouteDictionary.h"
#import "VVRoute.h"

@implementation VVRouteDictionary

+ (NSDictionary *)sharedDictionary {
    static NSDictionary *_sharedDictionary;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDictionary = @{@"Blue": [VVRoute routeWithRouteID:@"745"],
                              @"Red": [VVRoute routeWithRouteID:@"746"],
                              @"Green": [VVRoute routeWithRouteID:@"749"]};
    });
    
    return _sharedDictionary;
}

+ (VVRoute *)routeForName:(NSString *)name {
    return [self sharedDictionary][name];
}

@end
