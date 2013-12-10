//
//  VVVandyMobileAPIClient.h
//  Vandy Vans
//
//  Created by Seth Friedman on 1/27/13.
//  Copyright (c) 2013 VandyMobile. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface VVVandyMobileAPIClient : AFHTTPRequestOperationManager

+ (VVVandyMobileAPIClient *)sharedClient;

@end
