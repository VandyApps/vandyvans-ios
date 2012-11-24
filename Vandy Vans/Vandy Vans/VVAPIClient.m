//
//  VVAPIClient.m
//  Vandy Vans
//
//  Created by Seth Friedman on 11/24/12.
//  Copyright (c) 2012 VandyMobile. All rights reserved.
//

#import "VVAPIClient.h"
#import "AFJSONRequestOperation.h"

static NSString * const kVVAPIBaseURLString = @"http://api.synchromatics.com/";

@implementation VVAPIClient

+ (VVAPIClient *)sharedClient {
    static VVAPIClient *_sharedClient;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedClient = [[VVAPIClient alloc] initWithBaseURL:[NSURL URLWithString:kVVAPIBaseURLString]];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        
        // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
        [self setDefaultHeader:@"Accept" value:@"application/json"];
        
        self.parameterEncoding = AFFormURLParameterEncoding;
    }
    
    return self;
}

@end
