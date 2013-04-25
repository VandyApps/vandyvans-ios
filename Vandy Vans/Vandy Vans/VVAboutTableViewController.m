//
//  VVAboutTableViewController.m
//  Vandy Vans
//
//  Created by Seth Friedman on 1/19/13.
//  Copyright (c) 2013 VandyMobile. All rights reserved.
//

#import "VVAboutTableViewController.h"

@interface VVAboutTableViewController ()

@property (weak, nonatomic) IBOutlet UITableViewCell *reportBugTableViewCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *sendFeedbackTableViewCell;

@end

@implementation VVAboutTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
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

#pragma mark - Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    // We assume that we are dealing with the first section, as the other sections have no rows.
    if (indexPath.row == 0) {
        cell = self.reportBugTableViewCell;
    } else {
        cell = self.sendFeedbackTableViewCell;
    }
    
    return cell;
}

@end
