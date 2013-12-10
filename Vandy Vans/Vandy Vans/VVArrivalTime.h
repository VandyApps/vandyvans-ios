//
//  VVArrivalTime.h
//  Vandy Vans
//
//  Created by Seth Friedman on 11/24/12.
//  Copyright (c) 2012 VandyMobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VVArrivalTime : NSObject

@property (nonatomic, readonly, copy) NSString *stopName;
@property (nonatomic, readonly, copy) NSString *routeName;
@property (nonatomic, readonly) NSNumber *arrivalTimeInMinutes;

- (instancetype)initWithStopName:(NSString *)stopName routeName:(NSString *)routeName andArrivalTimeInMinutes:(NSNumber *)arrivalTimeInMinutes;

+ (void)arrivalTimesForStopID:(NSUInteger)stopID stopName:(NSString *)stopName withBlock:(void (^)(NSArray *arrivalTimesArray))block;

@end
