//
//  VVRoutes.h
//  Vandy Vans
//
//  Created by Seth Friedman on 3/27/14.
//  Copyright (c) 2014 VandyApps. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VVRoute;

// Wrapper around 3 singleton VVRoutes
@interface VVRouteDictionary : NSObject

+ (VVRoute *)routeForIdentifier:(NSString *)identifier;

@end
