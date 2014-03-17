//
//  VVReport.h
//  Vandy Vans
//
//  Created by Seth Friedman on 1/27/13.
//  Copyright (c) 2013 VandyApps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VVReport : NSObject

@property (nonatomic, readonly) BOOL isBugReport;
@property (nonatomic, readonly) NSString *senderAddress;
@property (nonatomic, readonly) NSString *body;
@property (nonatomic, readonly) BOOL notification;

- (id)initAsBugReport:(BOOL)asBugReport withSenderAddress:(NSString *)senderAddress body:(NSString *)body andNotification:(BOOL)notification;

- (void)sendWithBlock:(void (^)(void))block;

@end
