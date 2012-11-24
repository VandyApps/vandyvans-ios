//
//  VVArrivalTime.h
//  Vandy Vans
//
//  Created by Seth Friedman on 11/24/12.
//  Copyright (c) 2012 VandyMobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VVArrivalTime : NSObject

@property (nonatomic, readonly) NSString *stopName;
@property (nonatomic, readonly) NSInteger arrivalTimeInMinutes;

+ (void)arrivalTimesForStopID:(NSUInteger)stopID stopName:(NSString *)stopName withBlock:(void (^)(NSArray *arrivalTimes))block;

@end
