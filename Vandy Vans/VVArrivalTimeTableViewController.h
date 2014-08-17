//
//  VVArrivalTimeTableViewController.h
//  Vandy Vans
//
//  Created by Seth Friedman on 11/21/12.
//  Copyright (c) 2012 VandyApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VVStop;

@interface VVArrivalTimeTableViewController : UITableViewController

@property (strong, nonatomic) VVStop *selectedStop;

@end
