//
//  VVVandyMobileAPIClient.m
//  Vandy Vans
//
//  Created by Seth Friedman on 1/27/13.
//  Copyright (c) 2013 VandyMobile. All rights reserved.
//

#import "VVVandyMobileAPIClient.h"

static NSString * const kVVVandyMobileAPIBaseURLString = @"http://studentorgs.vanderbilt.edu/vandymobile/";

@implementation VVVandyMobileAPIClient

+ (VVVandyMobileAPIClient *)sharedClient {
    static VVVandyMobileAPIClient *_sharedClient;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedClient = [[VVVandyMobileAPIClient alloc] initWithBaseURL:[NSURL URLWithString:kVVVandyMobileAPIBaseURLString]];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        //[self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        
        // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
        //[self setDefaultHeader:@"Accept" value:@"application/json"];
    }
    
    return self;
}

@end
