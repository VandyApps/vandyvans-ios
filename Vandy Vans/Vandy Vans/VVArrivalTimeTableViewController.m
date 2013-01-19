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

@interface VVArrivalTimeTableViewController ()

@property (nonatomic) NSUInteger stopID;
@property (strong, nonatomic) NSOrderedSet *arrivalTimes;

@end

@implementation VVArrivalTimeTableViewController

@synthesize stopID = _stopID;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set up the refresh control and then refresh to load the initial data.
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [self refresh];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refresh {
    NSDateComponents *currentDateComponents = [[NSCalendar currentCalendar] components:NSHourCalendarUnit fromDate:[NSDate date]];
    
    // If it is not between 5 PM and 5 AM, alert the user that the vans are not running.
    if (currentDateComponents.hour > 5 && currentDateComponents.hour < 17) {
        // If it has just turned 5 AM, clear any cached arrival times and clear the table view.
        if (self.arrivalTimes.count != 0) {
            self.arrivalTimes = nil;
        }
        
        UIAlertView *vansNotRunningAlertView = [[UIAlertView alloc] initWithTitle:@"Vandy Vans Unavailable" message:@"The Vandy Vans are not currently running. Please try again after 5 PM." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [self.refreshControl endRefreshing];
        [vansNotRunningAlertView show];
    } else {
        [VVArrivalTime arrivalTimesForStopID:self.stopID stopName:self.title withBlock:^(NSArray *arrivalTimesArray) {
            [self.refreshControl endRefreshing];
            self.arrivalTimes = [NSOrderedSet orderedSetWithArray:arrivalTimesArray];
            
            // If the arrival times set is empty, there are currently no predictions.
            if (self.arrivalTimes.count == 0) {
                UIAlertView *noArrivalPredictionsAlertView = [[UIAlertView alloc] initWithTitle:@"No Predictions" message:@"There are no arrival predictions at this time." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [noArrivalPredictionsAlertView show];
            }
        }];
    }
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrivalTimes.count;
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
        cell = [tableView dequeueReusableCellWithIdentifier:PushNotificationCellIdentifier forIndexPath:indexPath];
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    NSString *footerTitle;
    
    if (section == 1) {
        footerTitle = @"Turn on push notifications to get alerted when the next van is closeby. These will be turned off automatically after you are alerted.";
    }
    
    return footerTitle;
}

@end
