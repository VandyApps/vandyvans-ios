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

@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly, copy) NSString *routeID;
@property (nonatomic, readonly) VVRouteColor routeColor;

- (instancetype)initWithRouteID:(NSString *)routeID;

+ (instancetype)routeWithRouteID:(NSString *)routeID;

/**
 * This method produces an array of all of the `MKPointAnnotation`s for the stops on a particular Vandy Van route.
 *
 * @param routeColor The color of the Vandy Van route selected.
 * @param completionBlock What to do with the stops once they are fetched.
 */
+ (void)annotationsForRoute:(VVRoute *)route withCompletionBlock:(void (^)(NSArray *stops))completionBlock;

/**
 * This method produces a `MKPolyline` overlay for a particular Vandy Van route.
 *
 * @param routeColor The color of the Vandy Van route selected.
 * @param completionBlock What to do with the polyline once it is fetched.
 */
+ (void)polylineForRoute:(VVRoute *)route withCompletionBlock:(void (^)(MKPolyline *polyline))completionBlock;

/**
 * This method produces an array of all of the `VVVan`s on a particular Vandy Van route.
 *
 * @param routeColor The color of the Vandy Van route selected.
 * @param completionBlock What to do with the vans once they are fetched.
 */
+ (void)vansForRoute:(VVRoute *)route withCompletionBlock:(void (^)(NSArray *vans))completionBlock;

@end