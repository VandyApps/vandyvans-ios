//
//  VVRoute.h
//  Vandy Vans
//
//  Created by Seth Friedman on 2/28/13.
//  Copyright (c) 2013 VandyMobile. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, VVRouteColor) {
    VVRouteColorBlue,
    VVRouteColorRed,
    VVRouteColorGreen
};

@class GMSPolyline;

@interface VVRoute : NSObject

/**
 * This method produces an array of all of the `GMSMarker`s for a particular Vandy Van route.
 *
 * @param routeColor The color of the Vandy Van route selected.
 *
 * @return An array of all of the `GMSMarker`s for the Vandy Van route.
 */
+ (NSArray *)markersForRouteColor:(VVRouteColor)routeColor;

/**
 * This method produces a `GMSPolyline` overlay for a particular Vandy Van route.
 *
 * @param routeColor The color of the Vandy Van route selected.
 *
 * @return A `GMSPolyline` for the Vandy Van route.
 */
+ (GMSPolyline *)polylineForRouteColor:(VVRouteColor)routeColor;

/**
 * This method gives the route ID for a particular Vandy Van route.
 *
 * @param routeColor The color of the Vandy Van route.
 *
 * @return A route ID.
 */
+ (NSInteger)routeIDForRouteColor:(VVRouteColor)routeColor __attribute__((const));

/**
 * This method gives the route color enum value for the name of a route.
 *
 * @param routeName The name of the Vandy Van route.
 *
 * @return The color enum value of the route.
 */
+ (VVRouteColor)routeColorForRouteName:(NSString *)routeName __attribute__((pure));

@end