//
//  VVBugReportTableViewController.m
//  Vandy Vans
//
//  Created by Seth Friedman on 1/19/13.
//  Copyright (c) 2013 VandyMobile. All rights reserved.
//

#import "VVReportTableViewController.h"

@interface VVReportTableViewController ()

@property (weak, nonatomic) IBOutlet UITableViewCell *descriptionTableViewCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *notifyWhenResolvedTableViewCell;

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

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger numberOfSections = 2;
    
    if (self.userIsSendingFeedback) {
        numberOfSections = 1;
    }
    
    return numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    if (indexPath.section == 0) {
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

@end
