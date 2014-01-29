//
//  VVMapViewController.h
//  Vandy Vans
//
//  Created by Seth Friedman on 10/11/12.
//  Copyright (c) 2012 VandyMobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VVSelectableRoute.h"

@class VVRoute;

@interface VVMapViewController : UIViewController <VVSelectableRoute>

@property (strong, nonatomic) VVRoute *selectedRoute;

@end
