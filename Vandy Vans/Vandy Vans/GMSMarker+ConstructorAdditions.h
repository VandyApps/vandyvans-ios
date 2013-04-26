//
//  GMSMarker+ConstructorAdditions.h
//  Vandy Vans
//
//  Created by Seth Friedman on 4/26/13.
//  Copyright (c) 2013 VandyMobile. All rights reserved.
//

#import <GoogleMaps/GoogleMaps.h>

@interface GMSMarker (ConstructorAdditions)

/** Convenience constructor for a marker with a particular latitude, longitude, and title. */
+ (instancetype)markerWithLatitude:(CGFloat)latitude longitude:(CGFloat)longitude andTitle:(NSString *)title;

@end
