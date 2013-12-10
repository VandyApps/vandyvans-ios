//
//  VVSyncromaticsClient.m
//  Vandy Vans
//
//  Created by Seth Friedman on 12/9/13.
//  Copyright (c) 2013 VandyMobile. All rights reserved.
//

#import "VVSyncromaticsClient.h"
#import "VVSyncromaticsResponseSerializer.h"

@import MapKit;

static NSString * const kVVSyncromaticsBaseURLString = @"http://vandyvans.com/";

@implementation VVSyncromaticsClient

#pragma mark - Designated Initializer

- (instancetype)initWithBaseURL:(NSURL *)url sessionConfiguration:(NSURLSessionConfiguration *)configuration {
    self = [super initWithBaseURL:url
             sessionConfiguration:configuration];
    
    if (self) {
        self.responseSerializer = [VVSyncromaticsResponseSerializer serializer];
    }
    
    return self;
}

#pragma mark - Singleton

+ (instancetype)sharedClient {
    static VVSyncromaticsClient *_sharedClient;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:10 * 1024 * 1024
                                                          diskCapacity:50 * 1024 * 1024
                                                              diskPath:nil];
        
        config.URLCache = cache;
        
        _sharedClient = [[VVSyncromaticsClient alloc] initWithBaseURL:[NSURL URLWithString:kVVSyncromaticsBaseURLString]
                                                 sessionConfiguration:config];
    });
    
    return _sharedClient;
}

#pragma mark - Class Method

+ (NSString *)apiKey {
    return @"a922a34dfb5e63ba549adbb259518909";
}

#pragma mark - Instance Methods

- (NSURLSessionDataTask *)fetchStopsForRouteColor:(VVRouteColor)routeColor withCompletionBlock:(void (^)(NSArray *stops, NSError *error))completionBlock {
    NSString *path = [[[[@"Route" stringByAppendingPathComponent:[NSString stringWithFormat:@"%li", (long)[VVRoute routeIDForRouteColor:routeColor]]] stringByAppendingPathComponent:@"Direction"] stringByAppendingPathComponent:@"0"] stringByAppendingPathComponent:@"Stops"];
    
    NSURLSessionDataTask *task = [[VVSyncromaticsClient sharedClient] GET:path
                                                               parameters:@{@"api_key": [VVSyncromaticsClient apiKey]}
                                                                  success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                      [self respondSuccessfullyWithTask:task
                                                                                         responseObject:responseObject
                                                                                     andCompletionBlock:completionBlock];
                                                                  } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                      [self respondUnsuccessfullyWithTask:task
                                                                                                    error:error
                                                                                       andCompletionBlock:completionBlock];
                                                                  }];
    
    return task;
}

- (NSURLSessionDataTask *)fetchPolylineForRouteColor:(VVRouteColor)routeColor withCompletionBlock:(void (^)(MKPolyline *polyline, NSError *error))completionBlock {
    NSString *path = [[@"Route" stringByAppendingPathComponent:[NSString stringWithFormat:@"%li", (long)[VVRoute routeIDForRouteColor:routeColor]]] stringByAppendingPathComponent:@"Waypoints"];
    
    NSURLSessionDataTask *task = [[VVSyncromaticsClient sharedClient] GET:path
                                                               parameters:@{@"api_key": [VVSyncromaticsClient apiKey]}
                                                                  success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                      [self respondSuccessfullyWithTask:task
                                                                                         responseObject:responseObject
                                                                                     andCompletionBlock:completionBlock];
                                                                  } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                      [self respondUnsuccessfullyWithTask:task
                                                                                                    error:error
                                                                                       andCompletionBlock:completionBlock];
                                                                  }];
    
    return task;
}

- (NSURLSessionDataTask *)fetchVansForRouteColor:(VVRouteColor)routeColor withCompletionBlock:(void (^)(NSArray *vans, NSError *error))completionBlock {
    NSString *path = [[@"Route" stringByAppendingPathComponent:[NSString stringWithFormat:@"%li", (long)[VVRoute routeIDForRouteColor:routeColor]]] stringByAppendingPathComponent:@"Vehicles"];
    
    NSURLSessionDataTask *task = [[VVSyncromaticsClient sharedClient] GET:path
                                                               parameters:@{@"api_key": [VVSyncromaticsClient apiKey]}
                                                                  success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                      [self respondSuccessfullyWithTask:task
                                                                                         responseObject:responseObject
                                                                                     andCompletionBlock:completionBlock];
                                                                  } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                      [self respondUnsuccessfullyWithTask:task
                                                                                                    error:error
                                                                                       andCompletionBlock:completionBlock];
                                                                  }];
    
    return task;
}

#pragma mark - Helper Methods

- (void)respondSuccessfullyWithTask:(NSURLSessionDataTask *)task responseObject:(id)responseObject andCompletionBlock:(void (^)(id retrievedObject, NSError *error))completionBlock {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
    
    if (httpResponse.statusCode == 200) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(responseObject, nil);
        });
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(nil, nil);
        });
        
        NSLog(@"Received: %@", responseObject);
        NSLog(@"Received HTTP %ld", (long)httpResponse.statusCode);
    }
}

- (void)respondUnsuccessfullyWithTask:(NSURLSessionDataTask *)task error:(NSError *)error andCompletionBlock:(void (^)(id retrievedObject, NSError *error))completionBlock {
    dispatch_async(dispatch_get_main_queue(), ^{
        completionBlock(nil, error);
    });
}

@end
