//
//  VVVan.m
//  Vandy Vans
//
//  Created by Seth Friedman on 12/10/13.
//  Copyright (c) 2013 VandyMobile. All rights reserved.
//

#import "VVVan.h"

@implementation VVVan

#pragma mark - Designated Initializer

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate andPercentageFull:(NSUInteger)percentageFull {
    self = [super init];
    
    if (self) {
        _coordinate = coordinate;
        _percentageFull = percentageFull;
    }
    
    return self;
}

#pragma mark - Factory Method

+ (instancetype)vanWithCoordinate:(CLLocationCoordinate2D)cooredinate andPercentageFull:(NSUInteger)percentageFull {
    return [[self alloc] initWithCoordinate:cooredinate
                          andPercentageFull:percentageFull];
}

@end
