//
//  VVVan.m
//  Vandy Vans
//
//  Created by Seth Friedman on 12/10/13.
//  Copyright (c) 2013 VandyApps. All rights reserved.
//

#import "VVVan.h"

@interface VVVan ()

@property (nonatomic, copy, readwrite) NSString *title;

@end

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

#pragma mark - Custom Getter

- (NSString *)title {
    if (!_title) {
        _title = [NSString stringWithFormat:@"%lu%% Full", (unsigned long)self.percentageFull];
    }
    
    return _title;
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
