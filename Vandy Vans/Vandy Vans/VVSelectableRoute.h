//
//  VVSelectableVan.h
//  Vandy Vans
//
//  Created by Seth Friedman on 1/29/14.
//  Copyright (c) 2014 VandyMobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VVRoute;

@protocol VVSelectableRoute <NSObject>

@property (strong, nonatomic) VVRoute *selectedRoute;

@end
