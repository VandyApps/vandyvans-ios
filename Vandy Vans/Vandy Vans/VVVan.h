//
//  VVVan.h
//  Vandy Vans
//
//  Created by Seth Friedman on 12/10/13.
//  Copyright (c) 2013 VandyMobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@import CoreLocation;

@interface VVVan : NSObject

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly) NSUInteger percentageFull;

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate andPercentageFull:(NSUInteger)percentageFull;

+ (instancetype)vanWithCoordinate:(CLLocationCoordinate2D)cooredinate andPercentageFull:(NSUInteger)percentageFull;

@end
