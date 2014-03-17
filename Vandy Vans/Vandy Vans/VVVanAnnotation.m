//
//  VVVanAnnotation.m
//  Vandy Vans
//
//  Created by Seth Friedman on 1/5/14.
//  Copyright (c) 2014 VandyApps. All rights reserved.
//

#import "VVVanAnnotation.h"

@implementation VVVanAnnotation

#pragma mark - Designated Initializer

- (instancetype)initWithTitle:(NSString *)title andCoordinate:(CLLocationCoordinate2D)coordinate {
    self = [super init];
    
    if (self) {
        _title = title;
        _coordinate = coordinate;
    }
    
    return self;
}

#pragma mark - Factory Method

+ (instancetype)vanAnnotationWithTitle:(NSString *)title andCoordinate:(CLLocationCoordinate2D)coordinate {
    return [[self alloc] initWithTitle:title
                         andCoordinate:coordinate];
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)object {
    BOOL equal = NO;
    
    if ([object isKindOfClass:[self class]]) {
        equal = (self.coordinate.latitude == [object coordinate].latitude) && (self.coordinate.longitude == [object coordinate].longitude);
    }
    
    return equal;
}

@end
