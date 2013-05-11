//
//  VVAboutTableViewController.m
//  Vandy Vans
//
//  Created by Seth Friedman on 1/19/13.
//  Copyright (c) 2013 VandyMobile. All rights reserved.
//

#import "VVAboutTableViewController.h"
#import "VVReportTableViewController.h"

@implementation VVAboutTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"VVAboutBackground-568h.jpg"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"AboutToSendFeedback"]) {
        VVReportTableViewController *reportTableViewController = (VVReportTableViewController *)segue.destinationViewController;
        
        reportTableViewController.userIsSendingFeedback = YES;
    }
}

- (IBAction)donePressed:(UIBarButtonItem *)sender {
    [self.delegate aboutTableViewControllerDidFinish:self];
}

@end
