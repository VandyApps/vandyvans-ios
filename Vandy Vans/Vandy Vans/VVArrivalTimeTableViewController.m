//
//  VVArrivalTimeTableViewController.m
//  Vandy Vans
//
//  Created by Seth Friedman on 11/21/12.
//  Copyright (c) 2012 VandyMobile. All rights reserved.
//

#import "VVArrivalTimeTableViewController.h"
#import "VVArrivalTime.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "VVAboutTableViewController.h"
#import "VVNotificationCell.h"
#import "VVAlertBuilder.h"
#import <GoogleAnalytics-iOS-SDK/GAI.h>

@interface VVArrivalTimeTableViewController () <UIAlertViewDelegate>

@property (nonatomic) NSUInteger stopID;
@property (strong, nonatomic) NSOrderedSet *arrivalTimes;
@property (nonatomic) BOOL vansAreRunning;

@end

@implementation VVArrivalTimeTableViewController

@synthesize arrivalTimes = _arrivalTimes;

- (NSUInteger)stopID {
    if (!_stopID) {
        if ([self.title isEqualToString:@"Branscomb Quad"]) {
            self.stopID = 263473;
        } else if ([self.title isEqualToString:@"Carmichael Towers"]) {
            self.stopID = 263470;
        } else if ([self.title isEqualToString:@"Murray House"]) {
            self.stopID = 263454;
        } else if ([self.title isEqualToString:@"Highland Quad"]) {
            self.stopID = 263444;
        } else if ([self.title isEqualToString:@"Vanderbilt Police Department"]) {
            self.stopID = 264041;
        } else if ([self.title isEqualToString:@"Vanderbilt Book Store"]) {
            self.stopID = 332298;
        } else if ([self.title isEqualToString:@"Kissam Quad"]) {
            self.stopID = 263415;
        } else if ([self.title isEqualToString:@"Terrace Place Garage"]) {
            self.stopID = 238083;
        } else if ([self.title isEqualToString:@"Wesley Place Garage"]) {
            self.stopID = 238096;
        } else if ([self.title isEqualToString:@"North House"]) {
            self.stopID = 263463;
        } else if ([self.title isEqualToString:@"Blair School of Music"]) {
            self.stopID = 264091;
        } else if ([self.title isEqualToString:@"McGugin Center"]) {
            self.stopID = 264101;
        } else {
            self.stopID = 401204;
        }
    }
    return _stopID;
}

- (NSOrderedSet *)arrivalTimes {
    if (!_arrivalTimes) {
        _arrivalTimes = [[NSOrderedSet alloc] init];
    }
    
    return _arrivalTimes;
}

- (void)setArrivalTimes:(NSOrderedSet *)arrivalTimes {
    if (_arrivalTimes != arrivalTimes) {
        _arrivalTimes = arrivalTimes;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.vansAreRunning = YES;
    
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"VVBackground"]];
    
    // Set up the refresh control and then refresh to load the initial data.
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [self refresh];
    
    // Google Analytics
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker sendView:@"Arrival Time View"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refresh {
    NSDateComponents *currentDateComponents = [[NSCalendar autoupdatingCurrentCalendar] components:NSHourCalendarUnit fromDate:[NSDate date]];
    
    // If it is between 5 AM and 5 PM, alert the user that the vans are not running.
    if (currentDateComponents.hour >= 5 && currentDateComponents.hour < 17) {
        self.vansAreRunning = NO;
        // If it has just turned 5 AM, clear any cached arrival times and clear the table view.
        if (self.arrivalTimes.count != 0) {
            self.arrivalTimes = nil;
        }
        
        UIAlertView *vansNotRunningAlertView = [VVAlertBuilder vansNotRunningAlertWithDelegate:self];
        [self.refreshControl endRefreshing];
        [vansNotRunningAlertView show];
    } else {
        [VVArrivalTime arrivalTimesForStopID:self.stopID stopName:self.title withBlock:^(NSArray *arrivalTimesArray) {
            [self.refreshControl endRefreshing];
            self.arrivalTimes = [NSOrderedSet orderedSetWithArray:arrivalTimesArray];
            
            // If the arrival times set is empty, there are currently no predictions.
            if (self.arrivalTimes.count == 0) {                
                UIAlertView *noArrivalPredictionsAlertView = [VVAlertBuilder noArrivalPredictionsAlert];
                [noArrivalPredictionsAlertView show];
            }
        }];
    }
}

- (IBAction)notificationSwitchPressed:(UISwitch *)sender {
    if (sender.on) {
        // If there is already a local notification scheduled for another stop, warn the user.
        NSArray *scheduledLocalNotifications = [UIApplication sharedApplication].scheduledLocalNotifications;
        if (scheduledLocalNotifications.count != 0) {
            UILocalNotification *scheduledNotification = scheduledLocalNotifications[0];
            
            UIAlertView *reminderAlreadyExistsAlertView = [VVAlertBuilder reminderAlreadyExistsAlertForStopName:scheduledNotification.userInfo[@"StopName"] newStopName:self.title delegate:self];
            [reminderAlreadyExistsAlertView show];
        } else {
            [self findAndScheduleNextArrivalTime];
        }
    } else {
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
    }
}

- (void)findAndScheduleNextArrivalTime {
    for (VVArrivalTime *arrivalTime in self.arrivalTimes) {
        if ([arrivalTime.arrivalTimeInMinutes integerValue] > 2) {
            [self scheduleNotificationWithArrivalTime:arrivalTime];
            
            // Create and display an alert to tell the user for which route and stop they have set a notification.
            UIAlertView *reminderSetAlertView = [VVAlertBuilder reminderSetAlertWithRouteName:arrivalTime.routeName andStopName:arrivalTime.stopName];
            [reminderSetAlertView show];
            
            break;
        }
    }
}

- (void)scheduleNotificationWithArrivalTime:(VVArrivalTime *)arrivalTime {
    NSDate *scheduledNotificationDate = [NSDate dateWithTimeIntervalSinceNow:(([arrivalTime.arrivalTimeInMinutes integerValue] - 2) * 60)];
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    
    localNotification.fireDate = scheduledNotificationDate;
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    
    localNotification.alertBody = [VVAlertBuilder vanArrivingAlertMessageWithRouteName:arrivalTime.routeName andStopName:arrivalTime.stopName];
    
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    ++localNotification.applicationIconBadgeNumber;
    
    localNotification.userInfo = @{@"StopName" : arrivalTime.stopName, @"RouteName" : arrivalTime.routeName};
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

#pragma mark - Table View Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    CGFloat footerHeight = 0;
    
    if (section == 1) {
        footerHeight = 300.0f;
    }
    
    return footerHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView;
    
    if (self.vansAreRunning && section == 1) {
        footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320.0f, 300.0f)];
        
        UILabel *footerTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 0, 280.0f, 95.0f)];
        footerTextLabel.opaque = YES;
        footerTextLabel.backgroundColor = [UIColor clearColor];
        footerTextLabel.shadowColor = [UIColor blackColor];
        footerTextLabel.numberOfLines = 0; // Removes any maximum number of lines.
        footerTextLabel.textAlignment = NSTextAlignmentCenter;
        
        NSString *footerText = @"Turn on reminders to be alerted when the next van is close-by. These will be turned off automatically after you get the reminder.";
        NSDictionary *footerTextAttributes = @{NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:15.0f], NSForegroundColorAttributeName : [UIColor whiteColor]};
        footerTextLabel.attributedText = [[NSAttributedString alloc] initWithString:footerText attributes:footerTextAttributes];
        
        [footerView addSubview:footerTextLabel];
    }
    
    return footerView;
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger numberOfRows = 0;
    
    if (section == 0) {
        numberOfRows = self.arrivalTimes.count;
    } else if (self.vansAreRunning) {
        numberOfRows = 1;
    }
    
    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ArrivalTimeCellIdentifier = @"ArrivalTimeCell";
    static NSString *PushNotificationCellIdentifier = @"PushNotificationCell";
    UITableViewCell *cell;
    
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:ArrivalTimeCellIdentifier forIndexPath:indexPath];
        
        // Configure the cell to display the route name and the number of minutes until arrival.
        VVArrivalTime *arrivalTime = [self.arrivalTimes objectAtIndex:indexPath.row];
        cell.textLabel.text = arrivalTime.routeName;
        
        if ([arrivalTime.arrivalTimeInMinutes intValue] == 0) {
            cell.detailTextLabel.text = @"Arriving";
        } else {
            cell.detailTextLabel.text = [[arrivalTime.arrivalTimeInMinutes stringValue] stringByAppendingString:@" minutes"];
        }
    } else {
        VVNotificationCell *notificationCell = [tableView dequeueReusableCellWithIdentifier:PushNotificationCellIdentifier];
        
        // If a local notification has already been scheduled for this stop, turn the switch on.
        NSArray *scheduledLocalNotifications = [UIApplication sharedApplication].scheduledLocalNotifications;
        if (scheduledLocalNotifications.count != 0) {
            UILocalNotification *scheduledNotification = scheduledLocalNotifications[0];
            if ([scheduledNotification.userInfo[@"StopName"] isEqualToString:self.title]) {
                [notificationCell.notificationSwitch setOn:YES animated:NO];
            }
        }
        
        cell = notificationCell;
    }
    
    return cell;
}

#pragma mark - Alert View Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        [self findAndScheduleNextArrivalTime];
        
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
