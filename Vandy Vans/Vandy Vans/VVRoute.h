//
//  VVRoute.h
//  Vandy Vans
//
//  Created by Seth Friedman on 2/28/13.
//  Copyright (c) 2013 VandyMobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMaps/GoogleMaps.h>

@interface VVRoute : NSObject

+ (NSArray *)markersForRouteName:(NSString *)routeName;

+ (GMSPolyline *)polylineForRouteName:(NSString *)routeName;

@end