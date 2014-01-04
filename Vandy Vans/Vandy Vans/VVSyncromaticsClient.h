//
//  VVSyncromaticsClient.h
//  Vandy Vans
//
//  Created by Seth Friedman on 12/9/13.
//  Copyright (c) 2013 VandyMobile. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@class VVRoute;
@class MKPolyline;
@class VVStop;

@interface VVSyncromaticsClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

/** This method gives the API key for accessing Syncromatics's Vandy Vans service. */
+ (NSString *)apiKey;

- (NSURLSessionDataTask *)fetchStopsForRoute:(VVRoute *)route withCompletionBlock:(void (^)(NSArray *stops, NSError *error))completionBlock;

- (NSURLSessionDataTask *)fetchPolylineForRoute:(VVRoute *)route withCompletionBlock:(void (^)(MKPolyline *polyline, NSError *error))completionBlock;

- (NSURLSessionDataTask *)fetchVansForRoute:(VVRoute *)route withCompletionBlock:(void (^)(NSArray *vans, NSError *error))completionBlock;

- (void)fetchArrivalTimesForStop:(VVStop *)stop withCompletionBlock:(void (^)(NSArray *arrivalTimes))completionBlock;

@end
