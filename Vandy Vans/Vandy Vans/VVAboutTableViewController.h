//
//  VVAboutTableViewController.h
//  Vandy Vans
//
//  Created by Seth Friedman on 1/19/13.
//  Copyright (c) 2013 VandyMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VVAboutTableViewController;

@protocol VVAboutTableViewControllerDelegate <NSObject>

- (void)aboutTableViewControllerDidFinish:(VVAboutTableViewController *)aboutTableViewController;

@end

@interface VVAboutTableViewController : UITableViewController

@property (weak, nonatomic) id <VVAboutTableViewControllerDelegate> delegate;

@end
