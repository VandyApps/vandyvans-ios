//
//  VVAPIClient.h
//  Vandy Vans
//
//  Created by Seth Friedman on 11/24/12.
//  Copyright (c) 2012 VandyMobile. All rights reserved.
//

#import "AFHTTPClient.h"

@interface VVAPIClient : AFHTTPClient

+ (VVAPIClient *)sharedClient;

/** This method gives the API key for accessing Syncromatics's Vandy Vans service. */
+ (NSString *)apiKey;

@end
