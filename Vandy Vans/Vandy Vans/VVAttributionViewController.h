//
//  VVAttributionViewController.h
//  Vandy Vans
//
//  Created by Seth Friedman on 5/6/13.
//  Copyright (c) 2013 VandyMobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleAnalytics-iOS-SDK/GAITrackedViewController.h>

@interface VVAttributionViewController : GAITrackedViewController

@property (weak, nonatomic) IBOutlet UITextView *attributionTextView;

@end
