//
//  VVVandyVansClient.m
//  Vandy Vans
//
//  Created by Seth Friedman on 1/30/14.
//  Copyright (c) 2014 VandyApps. All rights reserved.
//

#import "VVVandyVansClient.h"
#import "VVRoute.h"
#import "VVVandyVansResponseSerializer.h"

@import MapKit;

static NSString * const kVVVandyVansBaseURLString = @"http://vandyvans.com/";

@implementation VVVandyVansClient

#pragma mark - Designated Initializer

- (instancetype)initWithBaseURL:(NSURL *)url sessionConfiguration:(NSURLSessionConfiguration *)configuration {
    self = [super initWithBaseURL:url
             sessionConfiguration:configuration];
    
    if (self) {
        self.responseSerializer = [VVVandyVansResponseSerializer serializer];
    }
    
    return self;
}

#pragma mark - Singleton

+ (instancetype)sharedClient {
    static VVVandyVansClient *_sharedClient;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:10 * 1024 * 1024
                                                          diskCapacity:50 * 1024 * 1024
                                                              diskPath:nil];
        
        config.URLCache = cache;
        
        _sharedClient = [[VVVandyVansClient alloc] initWithBaseURL:[NSURL URLWithString:kVVVandyVansBaseURLString]
                                              sessionConfiguration:config];
    });
    
    return _sharedClient;
}

#pragma mark - Class Method

+ (NSString *)apiKey {
    return @"a922a34dfb5e63ba549adbb259518909";
}

#pragma mark - Instance Methods

- (NSURLSessionDataTask *)fetchStopsForRoute:(VVRoute *)route withCompletionBlock:(void (^)(NSArray *stops, NSError *error))completionBlock {
    NSString *path = [[[[@"Route" stringByAppendingPathComponent:route.routeID] stringByAppendingPathComponent:@"Direction"] stringByAppendingPathComponent:@"0"] stringByAppendingPathComponent:@"Stops"];
    
    NSURLSessionDataTask *task = [self GET:path
                                parameters:@{@"api_key": [self.class apiKey]}
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
