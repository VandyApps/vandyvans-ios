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

@class MKPolyline;

@interface VVRoute : NSObject

/**
 * This method produces an array of all of the `MKPointAnnotation`s for the stops on a particular Vandy Van route.
 *
 * @param routeColor The color of the Vandy Van route selected.
 * @param completionBlock What to do with the stops once they are fetched.
 */
+ (void)annotationsForRouteColor:(VVRouteColor)routeColor withCompletionBlock:(void (^)(NSArray *stops))completionBlock;

/**
 * This method produces a `MKPolyline` overlay for a particular Vandy Van route.
 *
 * @param routeColor The color of the Vandy Van route selected.
 * @param completionBlock What to do with the polyline once it is fetched.
 */
+ (void)polylineForRouteColor:(VVRouteColor)routeColor withCompletionBlock:(void (^)(MKPolyline *polyline))completionBlock;

/**
 * This method produces an array of all of the `VVVan`s on a particular Vandy Van route.
 *
 * @param routeColor The color of the Vandy Van route selected.
 * @param completionBlock What to do with the vans once they are fetched.
 */
+ (void)vansForRouteColor:(VVRouteColor)routeColor withCompletionBlock:(void (^)(NSArray *vans))completionBlock;

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