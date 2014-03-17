//
//  VVVan.h
//  Vandy Vans
//
//  Created by Seth Friedman on 12/10/13.
//  Copyright (c) 2013 VandyApps. All rights reserved.
//

#import <Foundation/Foundation.h>

@import CoreLocation;

@interface VVVan : NSObject

@property (nonatomic, readonly, copy) NSString *vanID;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly) NSUInteger percentageFull;

- (instancetype)initWithVanID:(NSString *)vanID
                   coordinate:(CLLocationCoordinate2D)coordinate
            andPercentageFull:(NSUInteger)percentageFull;

+ (instancetype)vanWithVanID:(NSString *)vanID
                  coordinate:(CLLocationCoordinate2D)coordinate
           andPercentageFull:(NSUInteger)percentageFull;

@end
