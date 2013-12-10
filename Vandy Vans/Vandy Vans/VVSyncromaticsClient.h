//
//  VVSyncromaticsClient.h
//  Vandy Vans
//
//  Created by Seth Friedman on 12/9/13.
//  Copyright (c) 2013 VandyMobile. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "VVRoute.h"

@class MKPolyline;

@interface VVSyncromaticsClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

/** This method gives the API key for accessing Syncromatics's Vandy Vans service. */
+ (NSString *)apiKey;

- (NSURLSessionDataTask *)fetchStopsForRouteColor:(VVRouteColor)routeColor withCompletionBlock:(void (^)(NSArray *stops, NSError *error))completionBlock;

- (NSURLSessionDataTask *)fetchPolylineForRouteColor:(VVRouteColor)routeColor withCompletionBlock:(void (^)(MKPolyline *polyline, NSError *error))completionBlock;

- (NSURLSessionDataTask *)fetchVansForRouteColor:(VVRouteColor)routeColor withCompletionBlock:(void (^)(NSArray *vans, NSError *error))completionBlock;

@end
