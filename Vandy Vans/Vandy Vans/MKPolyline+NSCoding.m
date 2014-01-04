//
//  MKPolyline+NSCoding.m
//  Vandy Vans
//
//  Created by Seth Friedman on 1/4/14.
//  Copyright (c) 2014 VandyMobile. All rights reserved.
//

#import "MKPolyline+NSCoding.h"

static NSString * const kXKey = @"x";
static NSString * const kYKey = @"y";
static NSString * const kTitleKey = @"title";
static NSString * const kSubtitleKey = @"subtitle";

@interface MKMultiPoint ()

@property (nonatomic, readwrite) MKMapPoint *points;

@end

@implementation MKPolyline (NSCoding)

- (id)initWithCoder:(NSCoder *)aDecoder {
    NSArray *xArray = [aDecoder decodeObjectForKey:kXKey];
    NSArray *yArray = [aDecoder decodeObjectForKey:kYKey];
    
    NSUInteger count = [xArray count];
    MKMapPoint pointArray[count];
    
    for (NSUInteger i = 0; i < count; ++i) {
        pointArray[i] = MKMapPointMake([xArray[i] doubleValue], [yArray[i] doubleValue]);
    }
    
    self = [self.class polylineWithPoints:pointArray
                                    count:count];
    
    if (self) {        
        self.title = [aDecoder decodeObjectForKey:kTitleKey];
        self.subtitle = [aDecoder decodeObjectForKey:kSubtitleKey];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    NSMutableArray *xArray = [NSMutableArray arrayWithCapacity:self.pointCount];
    NSMutableArray *yArray = [NSMutableArray arrayWithCapacity:self.pointCount];
    
    for (NSUInteger i = 0; i < self.pointCount; ++i) {
        MKMapPoint point = self.points[i];
        
        [xArray addObject:@(point.x)];
        [yArray addObject:@(point.y)];
    }
    
    [aCoder encodeObject:[xArray copy]
                  forKey:kXKey];
    [aCoder encodeObject:[yArray copy]
                  forKey:kYKey];
    
    [aCoder encodeObject:self.title
                  forKey:kTitleKey];
    [aCoder encodeObject:self.subtitle
                  forKey:kSubtitleKey];
}

@end
