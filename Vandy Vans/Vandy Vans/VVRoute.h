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

/**
 * This method produces an array of all of the `GMSMarker`s for a particular Vandy Van route.
 *
 * @param routeName The name of the Vandy Van route selected.
 *
 * @return An array of all of the `GMSMarker`s for the Vandy Van route.
 */
+ (NSArray *)markersForRouteName:(NSString *)routeName;

/**
 * This method produces a `GMSPolyline` overlay for a particular Vandy Van route.
 *
 * @param routeName The name of the Vandy Van route selected.
 *
 * @return A `GMSPolyline` for the Vandy Van route.
 */
+ (GMSPolyline *)polylineForRouteName:(NSString *)routeName;

/**
 * This method gives the route ID for a particular Vandy Van route.
 *
 * @param routeName The name of the Vandy Van route.
 *
 * @return A route ID.
 */
+ (NSInteger)routeIDForRouteName:(NSString *)routeName;

@end