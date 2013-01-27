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

- (void)sendWithBlock:(void (^)(void))block {
    NSDictionary *params = @{
        @"isBugReport" : self.isBugReport ? @"TRUE" : @"FALSE",
        @"senderAddress" : self.senderAddress,
        @"body" : self.body,
        @"notifyWhenResolved" : self.notification ? @"TRUE" : @"FALSE"
    };
    
    [[VVVandyMobileAPIClient sharedClient] postPath:@"bugReport.php" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([[responseObject objectForKey:@"status"] isEqualToString:@"success"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD showSuccessWithStatus:@"Report submitted!"];
            });
            
            if (block) {
                block();
            }
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD showErrorWithStatus:@"Report failed. Please try again later."];
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
