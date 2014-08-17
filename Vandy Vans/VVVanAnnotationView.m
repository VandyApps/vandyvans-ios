//
//  VVVanAnnotationView.m
//  Vandy Vans
//
//  Created by Seth Friedman on 1/5/14.
//  Copyright (c) 2014 VandyMobile. All rights reserved.
//

#import "VVVanAnnotationView.h"

@implementation VVVanAnnotationView

- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation
                     reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.image = [UIImage imageNamed:@"van"];
        self.canShowCallout = YES;
    }
    
    return self;
}

@end
