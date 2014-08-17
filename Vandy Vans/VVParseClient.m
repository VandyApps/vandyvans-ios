//
//  VVSyncromaticsClient.m
//  Vandy Vans
//
//  Created by Seth Friedman on 12/9/13.
//  Copyright (c) 2013 VandyApps. All rights reserved.
//

#import "VVParseClient.h"
#import "VVParseRequestSerializer.h"
#import "VVParseResponseSerializer.h"
#import "VVRoute.h"
#import "VVStop.h"

static NSString * const kVVParseBaseURLString = @"https://api.parse.com/1/functions/";

@implementation VVParseClient

#pragma mark - Designated Initializer

- (instancetype)initWithBaseURL:(NSURL *)url sessionConfiguration:(NSURLSessionConfiguration *)configuration {
    self = [super initWithBaseURL:url
             sessionConfiguration:configuration];
    
    if (self) {
        self.requestSerializer = [VVParseRequestSerializer serializer];
        self.responseSerializer = [VVParseResponseSerializer serializer];
    }
    
    return self;
}

#pragma mark - Singleton

+ (instancetype)sharedClient {
    static VVParseClient *_sharedClient;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:10 * 1024 * 1024
                                                          diskCapacity:50 * 1024 * 1024
                                                              diskPath:nil];
        
        config.URLCache = cache;
        
        _sharedClient = [[VVParseClient alloc] initWithBaseURL:[NSURL URLWithString:kVVParseBaseURLString]
                                          sessionConfiguration:config];
    });
    
    return _sharedClient;
}

#pragma mark - Instance Methods

- (NSURLSessionDataTask *)fetchVansForRoute:(VVRoute *)route withCompletionBlock:(void (^)(NSArray *vans, NSError *error))completionBlock {
    NSString *path = [[@"Route" stringByAppendingPathComponent:route.routeID] stringByAppendingPathComponent:@"Vehicles"];
    
    NSURLSessionDataTask *task = [self GET:path
                                parameters:nil
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

- (void)fetchArrivalTimesForStop:(VVStop *)stop withCompletionBlock:(void (^)(NSArray *arrivalTimes))completionBlock {
    [self POST:@"arrivalTimes"
    parameters:@{@"stopID": stop.stopID}
       success:^(NSURLSessionDataTask *task, id responseObject) {
           NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
           
           if (httpResponse.statusCode == 200) {
               completionBlock(responseObject);
           }
       } failure:^(NSURLSessionDataTask *task, NSError *error) {
           // At some point, the completion block should probably be called regardless with some sort of NSError. This would also make it automatically
           // go back to the Stops view.
           [[[UIAlertView alloc] initWithTitle:@"Site Down"
                                       message:@"We are sorry for the inconvenience, but VandyVans.com is currently down. Please try again later."
                                      delegate:nil
                             cancelButtonTitle:@"OK"
                             otherButtonTitles:nil] show];
           //completionBlock(nil);
       }];
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
