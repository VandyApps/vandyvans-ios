//
//  VVReport.m
//  Vandy Vans
//
//  Created by Seth Friedman on 1/27/13.
//  Copyright (c) 2013 VandyMobile. All rights reserved.
//

#import "VVReport.h"
#import "VVVandyMobileAPIClient.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <SAMCategories/SAMCategories.h>

@implementation VVReport

@synthesize isBugReport = _isBugReport;
@synthesize senderAddress = _senderAddress;
@synthesize body = _body;
@synthesize notification = _notification;

- (id)initAsBugReport:(BOOL)asBugReport withSenderAddress:(NSString *)senderAddress body:(NSString *)body andNotification:(BOOL)notification {
    self = [super init];
    
    if (self) {
        _isBugReport = asBugReport;
        _senderAddress = senderAddress;
        _body = body;
        _notification = notification;
    }
    
    return self;
}

// TODO - Refactor this with GCD. Note: AFNetworking already calls the success and failure blocks on separate threads.
- (void)sendWithBlock:(void (^)(void))block {
    NSDictionary *params = @{
        @"verifyHash" : [@"vandyvansapp" sam_SHA1Digest],
        @"isBugReport" : self.isBugReport ? @"TRUE" : @"FALSE",
        @"senderAddress" : self.senderAddress,
        @"body" : self.body,
        @"notifyWhenResolved" : self.notification ? @"TRUE" : @"FALSE"
    };
    
    [[VVVandyMobileAPIClient sharedClient] POST:@"bugReport.php"
                                     parameters:params
                                        success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                            NSString *response = [responseObject objectForKey:@"status"];
                                            
                                            if ([response isEqualToString:@"success"]) {
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    [SVProgressHUD showSuccessWithStatus:@"Report submitted!"];
                                                });
                                                
                                                if (block) {
                                                    block();
                                                }
                                            } else if ([response isEqualToString:@"invalid email"]) {
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    [SVProgressHUD showErrorWithStatus:@"Invalid email address. Please try again."];
                                                });
                                            }
                                        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                            NSLog(@"Error: %@", error);
                                            
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                [SVProgressHUD showErrorWithStatus:@"Report failed. Please try again later."];
                                            });
                                        }];
}

@end
