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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSDateComponents *currentDateComponents = [[NSCalendar currentCalendar] components:NSHourCalendarUnit fromDate:[NSDate date]];
    
    if (currentDateComponents.hour > 5 && currentDateComponents.hour < 17) {
        UIAlertView *vansNotRunningAlertView = [[UIAlertView alloc] initWithTitle:@"Vandy Vans Unavailable" message:@"The Vandy Vans are not currently running. Please try again after 5 PM." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [vansNotRunningAlertView show];
    } else {
        [VVArrivalTime arrivalTimesForStopID:self.stopID stopName:self.title withBlock:^(NSArray *arrivalTimes) {
            self.arrivalTimes = [NSOrderedSet orderedSetWithArray:arrivalTimes];
        }];
    }

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.arrivalTimes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
