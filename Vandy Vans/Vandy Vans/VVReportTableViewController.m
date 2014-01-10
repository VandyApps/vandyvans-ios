//
//  VVBugReportTableViewController.m
//  Vandy Vans
//
//  Created by Seth Friedman on 1/19/13.
//  Copyright (c) 2013 VandyMobile. All rights reserved.
//

#import "VVReportTableViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "VVVandyMobileAPIClient.h"
#import "VVReport.h"
#import <SAMTextView/SAMTextView.h>

@interface VVReportTableViewController ()

@property (weak, nonatomic) IBOutlet UITableViewCell *notifyWhenResolvedTableViewCell;

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet SAMTextView *descriptionTextView;

@end

@implementation VVReportTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.userIsSendingFeedback) {
        self.title = @"Send Feedback";
    }
    
    self.descriptionTextView.placeholder = @"Description";
    
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"VVBackground"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendPressed:(UIBarButtonItem *)sender {
    // TODO - This can be changed into an unwind segue
    if ([self.emailTextField.text isEqualToString:@""] || [self.descriptionTextView.text isEqualToString:@"Description"]) {
        [SVProgressHUD showErrorWithStatus:@"Please fill in the email and description fields."];
    }
    
    VVReport *report = [[VVReport alloc] initAsBugReport:!self.userIsSendingFeedback
                                       withSenderAddress:self.emailTextField.text
                                                    body:self.descriptionTextView.text
                                         andNotification:(self.notifyWhenResolvedTableViewCell.accessoryType == UITableViewCellAccessoryCheckmark)];
    [report sendWithBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    }];
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger numberOfSections = 3;
    
    if (self.userIsSendingFeedback) {
        numberOfSections = 2;
    }
    
    return numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        if (self.notifyWhenResolvedTableViewCell.accessoryType == UITableViewCellAccessoryCheckmark) {
            self.notifyWhenResolvedTableViewCell.accessoryType = UITableViewCellAccessoryNone;
        } else {
            self.notifyWhenResolvedTableViewCell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
}

@end
