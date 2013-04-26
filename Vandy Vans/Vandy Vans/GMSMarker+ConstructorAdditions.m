//
//  GMSMarker+ConstructorAdditions.m
//  Vandy Vans
//
//  Created by Seth Friedman on 4/26/13.
//  Copyright (c) 2013 VandyMobile. All rights reserved.
//

#import "GMSMarker+ConstructorAdditions.h"

@implementation GMSMarker (ConstructorAdditions)

+ (instancetype)markerWithLatitude:(CGFloat)latitude longitude:(CGFloat)longitude andTitle:(NSString *)title {
    GMSMarker *marker = [GMSMarker markerWithPosition:CLLocationCoordinate2DMake(latitude, longitude)];
    marker.title = title;
    
    return marker;
}

@end
