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

#pragma mark - View Controller Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"VVBackgroundFull"]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar.layer removeAllAnimations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"AboutToSendFeedback"]) {
        VVReportTableViewController *reportTableViewController = (VVReportTableViewController *)segue.destinationViewController;
        
        reportTableViewController.userIsSendingFeedback = YES;
    }
}

#pragma mark - IB Action

/* Fix jumpy navbar bug: http://stackoverflow.com/questions/19136899/navigation-bar-has-wrong-position-when-modal-a-view-controller-with-flip-horizon/19265558#19265558 */
- (IBAction)doneTapped:(UIBarButtonItem *)sender {
    [UIView transitionWithView:self.navigationController.view
                      duration:1
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:nil
                    completion:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table View Delegate

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, tableView.bounds.size.height - ([self tableView:self.tableView heightForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]] * [self tableView:self.tableView numberOfRowsInSection:0]))];
        
    UILabel *footerTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 0, footerView.bounds.size.width - 40.0f, footerView.bounds.size.height)];
    footerTextLabel.opaque = YES;
    footerTextLabel.backgroundColor = [UIColor clearColor];
    footerTextLabel.shadowColor = [UIColor blackColor];
    footerTextLabel.numberOfLines = 0; // Removes any maximum number of lines.
    footerTextLabel.textAlignment = NSTextAlignmentCenter;
    
    footerTextLabel.attributedText = [self footerText];
        
    [footerView addSubview:footerTextLabel];
    
    return footerView;
}

#pragma mark - Helper Method

- (NSAttributedString *)footerText {
    NSDictionary *nameTextAttributes = @{NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:17.0f], NSForegroundColorAttributeName : [UIColor whiteColor]};
    NSDictionary *smallerTextAttributes = @{NSFontAttributeName : [UIFont fontWithName:@"Helvetica" size:15.0f], NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    NSMutableAttributedString *footerText = [[NSMutableAttributedString alloc] initWithString:@"CREATED BY:\n" attributes:smallerTextAttributes];
    [footerText appendAttributedString:[[NSAttributedString alloc] initWithString:@"SETH FRIEDMAN" attributes:nameTextAttributes]];
    [footerText appendAttributedString:[[NSAttributedString alloc] initWithString:@"\nand\n" attributes:smallerTextAttributes]];
    [footerText appendAttributedString:[[NSAttributedString alloc] initWithString:@"MCARTHUR GILL\n\n" attributes:nameTextAttributes]];
    [footerText appendAttributedString:[[NSAttributedString alloc] initWithString:@"GRAPHIC DESIGN BY:\n" attributes:smallerTextAttributes]];
    [footerText appendAttributedString:[[NSAttributedString alloc] initWithString:@"FLETCHER YOUNG" attributes:nameTextAttributes]];
    
    return [footerText copy];
}

@end
