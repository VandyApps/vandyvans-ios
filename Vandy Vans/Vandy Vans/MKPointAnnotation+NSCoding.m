//
//  MKPointAnnotation+NSCoding.m
//  Vandy Vans
//
//  Created by Seth Friedman on 1/4/14.
//  Copyright (c) 2014 VandyMobile. All rights reserved.
//

#import "MKPointAnnotation+NSCoding.h"

static NSString * const kLatitudeKey = @"latitude";
static NSString * const kLongitudeKey = @"longitude";
static NSString * const kTitleKey = @"title";
static NSString * const kSubtitleKey = @"subtitle";

@implementation MKPointAnnotation (NSCoding)

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    
    if (self) {
        self.coordinate = CLLocationCoordinate2DMake([aDecoder decodeDoubleForKey:kLatitudeKey], [aDecoder decodeDoubleForKey:kLongitudeKey]);
        self.title = [aDecoder decodeObjectForKey:kTitleKey];
        self.subtitle = [aDecoder decodeObjectForKey:kSubtitleKey];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeDouble:self.coordinate.latitude
                  forKey:kLatitudeKey];
    [aCoder encodeDouble:self.coordinate.longitude
                  forKey:kLongitudeKey];
    [aCoder encodeObject:self.title
                  forKey:kTitleKey];
    [aCoder encodeObject:self.subtitle
                  forKey:kSubtitleKey];
}

@end
