//
//  VVAWSClient.h
//  Vandy Vans
//
//  Created by Seth Friedman on 12/9/13.
//  Copyright (c) 2013 VandyApps. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@class VVRoute;
@class VVStop;
@class MKPolyline;

@interface VVAWSClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

- (NSURLSessionDataTask *)fetchVansForRoute:(VVRoute *)route withCompletionBlock:(void (^)(NSArray *vans, NSError *error))completionBlock;

- (void)fetchArrivalTimesForStop:(VVStop *)stop withCompletionBlock:(void (^)(NSArray *arrivalTimes))completionBlock;

- (NSURLSessionDataTask *)fetchPolylineForRoute:(VVRoute *)route withCompletionBlock:(void (^)(MKPolyline *polyline, NSError *error))completionBlock;

@end
