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
        _sharedDictionary = @{kBlackRouteID: [VVRoute routeWithRouteID:kBlackRouteID],
                              kRedRouteID: [VVRoute routeWithRouteID:kRedRouteID],
                              kGoldRouteID: [VVRoute routeWithRouteID:kGoldRouteID]};
    });
    
    return _sharedDictionary;
}

+ (VVRoute *)routeForIdentifier:(NSString *)identifier {
    return [self sharedDictionary][identifier];
}

@end
