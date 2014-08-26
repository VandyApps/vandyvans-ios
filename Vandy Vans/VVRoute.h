//
//  VVRoute.h
//  Vandy Vans
//
//  Created by Seth Friedman on 2/28/13.
//  Copyright (c) 2013 VandyApps. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, VVRouteColor) {
    VVRouteColorBlack,
    VVRouteColorRed,
    VVRouteColorGold
};

extern NSString * const kBlackRouteID;
extern NSString * const kRedRouteID;
extern NSString * const kGoldRouteID;

extern NSString * const kBlackMapRouteID;
extern NSString * const kRedMapRouteID;
extern NSString * const kGoldMapRouteID;

extern NSString * const kAnnotationsDateKey;
extern NSString * const kBlackAnnotationsDateKey;
extern NSString * const kRedAnnotationsDateKey;
extern NSString * const kGoldAnnotationsDateKey;

extern NSString * const kPolylineDateKey;
extern NSString * const kBlackPolylineDateKey;
extern NSString * const kRedPolylineDateKey;
extern NSString * const kGoldPolylineDateKey;

@class MKPolyline;

@interface VVRoute : NSObject

@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly, copy) NSString *routeID;
@property (nonatomic, readonly, copy) NSString *mapRouteID;
@property (nonatomic, readonly) VVRouteColor routeColor;

- (instancetype)initWithRouteID:(NSString *)routeID;

+ (instancetype)routeWithRouteID:(NSString *)routeID;

/**
 *  This method produces an array of all of the `MKPointAnnotation`s for the stops on a particular Vandy Van route.
 *
 *  @param route           The Vandy Van route selected.
 *  @param completionBlock What to do with the stops once they are fetched.
 */
+ (void)annotationsForRoute:(VVRoute *)route withCompletionBlock:(void (^)(NSArray *stops))completionBlock;

/**
 *  This method produces a `MKPolyline` overlay for a particular Vandy Van route.
 *
 *  @param route           The Vandy Van route selected.
 *  @param completionBlock What to do with the polyline once it is fetched.
 */
+ (void)polylineForRoute:(VVRoute *)route withCompletionBlock:(void (^)(MKPolyline *polyline))completionBlock;

/**
 *  This method produces an array of all of the `VVVan`s on a particular Vandy Van route.
 *
 *  @param route           The Vandy Van route selected
 *  @param completionBlock What to do with the vans once they are fetched.
 *
 *  @return The data task that is fetching the vans.
 */
+ (NSURLSessionDataTask *)vansForRoute:(VVRoute *)route withCompletionBlock:(void (^)(NSArray *vans))completionBlock;

@end