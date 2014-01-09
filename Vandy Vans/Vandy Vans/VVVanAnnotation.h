//
//  VVVanAnnotation.h
//  Vandy Vans
//
//  Created by Seth Friedman on 1/5/14.
//  Copyright (c) 2014 VandyMobile. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface VVVanAnnotation : NSObject <MKAnnotation>

@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (instancetype)initWithTitle:(NSString *)title andCoordinate:(CLLocationCoordinate2D)coordinate;

+ (instancetype)vanAnnotationWithTitle:(NSString *)title andCoordinate:(CLLocationCoordinate2D)coordinate;

@end
