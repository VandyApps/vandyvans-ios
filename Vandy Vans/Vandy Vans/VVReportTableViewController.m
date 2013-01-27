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

@interface VVReportTableViewController ()

@property (weak, nonatomic) IBOutlet UITableViewCell *emailTableViewCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *descriptionTableViewCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *notifyWhenResolvedTableViewCell;

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;

@end

@implementation VVReportTableViewController

@synthesize userIsSendingFeedback = _userIsSendingFeedback;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.userIsSendingFeedback) {
        self.title = @"Send Feedback";
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendPressed:(UIBarButtonItem *)sender {
    if ([self.emailTextField.text isEqualToString:@""] || [self.descriptionTextView.text isEqualToString:@"Description"]) {
        [SVProgressHUD showErrorWithStatus:@"Please fill in the email and description fields."];
    }
    
    VVReport *report = [[VVReport alloc] initAsBugReport:!self.userIsSendingFeedback withSenderAddress:self.emailTextField.text body:self.descriptionTextView.text andNotification:(self.notifyWhenResolvedTableViewCell.accessoryType == UITableViewCellAccessoryCheckmark)];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    if (indexPath.section == 0) {
        cell = self.emailTableViewCell;
    } else if (indexPath.section == 1) {
        cell = self.descriptionTableViewCell;
    } else if (!self.userIsSendingFeedback) {
        cell = self.notifyWhenResolvedTableViewCell;
    }
    
    return cell;
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if (self.notifyWhenResolvedTableViewCell.accessoryType == UITableViewCellAccessoryCheckmark) {
            self.notifyWhenResolvedTableViewCell.accessoryType = UITableViewCellAccessoryNone;
        } else {
            self.notifyWhenResolvedTableViewCell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
}

#pragma mark - Text View Delegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"Description"]) {
        textView.textColor = [UIColor blackColor];
        textView.text = @"";
    }
    
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@""]) {
        textView.textColor = [UIColor lightGrayColor];
        textView.text = @"Description";
    }
}

@end
