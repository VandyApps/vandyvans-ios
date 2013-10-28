//
//  VVAppearanceBuilder.m
//  Vandy Vans
//
//  Created by Seth Friedman on 5/6/13.
//  Copyright (c) 2013 VandyMobile. All rights reserved.
//

#import "VVAppearanceBuilder.h"
#import "VVStopTableViewController.h"
#import "VVAboutTableViewController.h"

@implementation VVAppearanceBuilder

+ (void)buildAppearance {
    // Set the background view in the table views to the default application background.
    //[[UITableView appearanceWhenContainedIn:[UINavigationController class], nil] setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"VVBackground"]]];
    
    [[UITableView appearanceWhenContainedIn:[VVStopTableViewController class], nil] setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"VVBackground"]]];
    
    //[[UITableView appearanceWhenContainedIn:[VVAboutTableViewController class], nil] setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"VVBackgroundFull"]]];
}

@end
