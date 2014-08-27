//
//  AWSMobileAnalytics+VandyVans.m
//  Vandy Vans
//
//  Created by Seth Friedman on 8/26/14.
//  Copyright (c) 2014 VandyApps. All rights reserved.
//

#import "AWSMobileAnalytics+VandyVans.h"

@implementation AWSMobileAnalytics (VandyVans)

+ (instancetype)vv_mobileAnalytics {
    return [AWSMobileAnalytics mobileAnalyticsForAppId:[[[[UIDevice currentDevice] identifierForVendor] UUIDString] stringByAppendingString:@"edu.vanderbilt.vandyvans"]];
}

@end
