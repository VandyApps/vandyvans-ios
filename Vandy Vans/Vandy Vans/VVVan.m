//
//  VVVan.m
//  Vandy Vans
//
//  Created by Seth Friedman on 12/10/13.
//  Copyright (c) 2013 VandyApps. All rights reserved.
//

#import "VVVan.h"

@implementation VVVan

#pragma mark - Designated Initializer

- (instancetype)initWithVanID:(NSString *)vanID coordinate:(CLLocationCoordinate2D)coordinate andPercentageFull:(NSUInteger)percentageFull {
    self = [super init];
    
    if (self) {
        _vanID = vanID;
        _coordinate = coordinate;
        _percentageFull = percentageFull;
    }
    
    return self;
}

#pragma mark - Factory Method

+ (instancetype)vanWithVanID:(NSString *)vanID coordinate:(CLLocationCoordinate2D)coordinate andPercentageFull:(NSUInteger)percentageFull {
    return [[self alloc] initWithVanID:vanID
                            coordinate:coordinate
                          andPercentageFull:percentageFull];
}

@end
