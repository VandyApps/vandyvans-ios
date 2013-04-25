//
//  VVVandyMobileAPIClient.h
//  Vandy Vans
//
//  Created by Seth Friedman on 1/27/13.
//  Copyright (c) 2013 VandyMobile. All rights reserved.
//

#import "AFHTTPClient.h"

@interface VVVandyMobileAPIClient : AFHTTPClient

+ (VVVandyMobileAPIClient *)sharedClient;

@end
