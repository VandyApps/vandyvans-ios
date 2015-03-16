//
//  VVAboutTableViewController.m
//  Vandy Vans
//
//  Created by Seth Friedman on 1/19/13.
//  Copyright (c) 2013 VandyApps. All rights reserved.
//

#import "VVAboutTableViewController.h"
#import "AWSMobileAnalytics+VandyVans.h"
@import MessageUI;

static NSString * const kOpenedAboutViewEventType = @"OpenedAboutView";
static NSString * const kVandyVansEmailAddress = @"vandyvansapp@gmail.com";
static NSString * const kBugReportSubject = @"Vandy Vans Bug Report";
static NSString * const kFeedbackSubject = @"Vandy Vans Feedback";

@interface VVAboutTableViewController () <MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) id<AWSMobileAnalyticsEventClient> eventClient;

@end

@implementation VVAboutTableViewController

#pragma mark - Custom Getters

- (id<AWSMobileAnalyticsEventClient>)eventClient {
    if (!_eventClient) {
        AWSMobileAnalytics *analytics = [AWSMobileAnalytics vv_mobileAnalytics];
        _eventClient = analytics.eventClient;
    }
    
    return _eventClient;
}

#pragma mark - View Controller Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"VVBackgroundFull"]];
    
    id<AWSMobileAnalyticsEvent> openedAboutViewEvent = [self.eventClient createEventWithEventType:kOpenedAboutViewEventType];
    [self.eventClient recordEvent:openedAboutViewEvent];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Report a Bug or Send Feedback
    if (indexPath.row == 0 || indexPath.row == 1) {
        NSString *subject;
        
        if (indexPath.row == 0) {
            subject = kBugReportSubject;
        } else {
            subject = kFeedbackSubject;
        }
        
        MFMailComposeViewController *composeViewController = [[MFMailComposeViewController alloc] init];
        [composeViewController setToRecipients:@[kVandyVansEmailAddress]];
        [composeViewController setSubject:subject];
        
        [self presentViewController:composeViewController
                           animated:YES
                         completion:nil];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320.0f, 300.0f)];
    
    UILabel *footerTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 10.0f, 280.0f, 190.0f)];
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
    NSDictionary *nameTextAttributes = @{NSFontAttributeName : [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline], NSForegroundColorAttributeName : [UIColor whiteColor]};
    NSDictionary *smallerTextAttributes = @{NSFontAttributeName : [UIFont preferredFontForTextStyle:UIFontTextStyleBody], NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    NSMutableAttributedString *footerText = [[NSMutableAttributedString alloc] initWithString:@"CREATED BY:\n"
                                                                                   attributes:smallerTextAttributes];
    [footerText appendAttributedString:[[NSAttributedString alloc] initWithString:@"SETH FRIEDMAN\n\n"
                                                                       attributes:nameTextAttributes]];
    [footerText appendAttributedString:[[NSAttributedString alloc] initWithString:@"GRAPHIC DESIGN BY:\n"
                                                                       attributes:smallerTextAttributes]];
    [footerText appendAttributedString:[[NSAttributedString alloc] initWithString:@"FLETCHER YOUNG\n\n"
                                                                       attributes:nameTextAttributes]];
    
    return [footerText copy];
}

#pragma mark - MFMailComposeViewController Delegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

@end
