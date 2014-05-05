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
        _sharedDictionary = @{@"745": [VVRoute routeWithRouteID:@"745"],
                              @"746": [VVRoute routeWithRouteID:@"746"],
                              @"749": [VVRoute routeWithRouteID:@"749"]};
    });
    
    return _sharedDictionary;
}

+ (VVRoute *)routeForIdentifier:(NSString *)identifier {
    return [self sharedDictionary][identifier];
}

@end
