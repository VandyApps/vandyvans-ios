//
//  VVArrivalTime.h
//  Vandy Vans
//
//  Created by Seth Friedman on 11/24/12.
//  Copyright (c) 2012 VandyMobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VVStop;
@class VVRoute;
@class VVVan;

@interface VVArrivalTime : NSObject

@property (strong, nonatomic, readonly) VVStop *stop;
@property (strong, nonatomic, readonly) VVRoute *route;
@property (strong, nonatomic, readonly) NSNumber *arrivalTimeInMinutes;

- (instancetype)initWithStop:(VVStop *)stop
                       route:(VVRoute *)route
     andArrivalTimeInMinutes:(NSNumber *)arrivalTimeInMinutes;

+ (instancetype)arrivalTimeWithStop:(VVStop *)stop
                              route:(VVRoute *)route
            andArrivalTimeInMinutes:(NSNumber *)arrivalTimeInMinutes;

+ (void)arrivalTimesForStop:(VVStop *)stop withBlock:(void (^)(NSArray *arrivalTimesArray))block;

@end
