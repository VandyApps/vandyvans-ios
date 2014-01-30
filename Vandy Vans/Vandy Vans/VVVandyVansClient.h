//
//  VVVandyVansClient.h
//  Vandy Vans
//
//  Created by Seth Friedman on 1/30/14.
//  Copyright (c) 2014 VandyMobile. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@class VVRoute;
@class MKPolyline;

@interface VVVandyVansClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

/** This method gives the API key for accessing Syncromatics's Vandy Vans service. */
+ (NSString *)apiKey;

- (NSURLSessionDataTask *)fetchStopsForRoute:(VVRoute *)route withCompletionBlock:(void (^)(NSArray *stops, NSError *error))completionBlock;

- (NSURLSessionDataTask *)fetchPolylineForRoute:(VVRoute *)route withCompletionBlock:(void (^)(MKPolyline *polyline, NSError *error))completionBlock;

@end
