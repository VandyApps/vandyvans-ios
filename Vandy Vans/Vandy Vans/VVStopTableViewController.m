//
//  VVArrivalTimeTableViewController.m
//  Vandy Vans
//
//  Created by Seth Friedman on 10/11/12.
//  Copyright (c) 2012 VandyMobile. All rights reserved.
//

#import "VVStopTableViewController.h"
#import "VVArrivalTimeTableViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <GoogleAnalytics-iOS-SDK/GAI.h>

@interface VVStopTableViewController ()

@property (strong, nonatomic) NSArray *stops;

@end

@implementation VVStopTableViewController

@synthesize stops = _stops;

- (NSArray *)stops {
    if (!_stops) {
        if ([self.title isEqualToString:@"Stops"]) {
            _stops = @[@"Branscomb Quad", @"Carmichael Towers", @"Murray House", @"Highland Quad", @"Other Stops"];
        } else {
            _stops = @[@"Vanderbilt Police Department", @"Vanderbilt Book Store", @"Kissam Quad", @"Terrace Place Garage",
                @"Wesley Place Garage", @"North House", @"Blair School of Music", @"McGugin Center", @"Blakemore House", @"Medical Center"];
        }
    }
    return _stops;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Google Analytics
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    // If the title has not yet been set, it is the Stops view, not the Other Stops view.
    if (!self.title) {
        self.title = @"Stops";
        [tracker sendView:@"Stops View"];
    } else {
        [tracker sendView:@"Other Stops View"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"StopsToArrivalTimes"]) {
        ((VVArrivalTimeTableViewController *)segue.destinationViewController).title = ((UITableViewCell *)sender).textLabel.text;
    } else if ([segue.identifier isEqualToString:@"StopsToOtherStops"]) {
        ((VVStopTableViewController *)segue.destinationViewController).title = @"Other Stops";
    }
}

#pragma mark - IB Action

- (IBAction)aboutViewDismissed:(UIStoryboardSegue *)segue {}

#pragma mark - Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.stops.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Stop";
    static NSString *OtherCellIdentifier = @"OtherStops";
    UITableViewCell *cell;
    
    if ([self.title isEqualToString:@"Stops"]) {
        // If this is the Stops table view, check to see which cell is being retrieved. If it is not the last one, return
        // a normal stop cell. If it is, return the cell for "Other Stops".
        cell = (indexPath.row != (self.stops.count - 1)) ? [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath] : [tableView dequeueReusableCellWithIdentifier:OtherCellIdentifier forIndexPath:indexPath];
    } else {
        // If it is not the Stops table view, just return the next cell as normal.
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    }
    
    cell.textLabel.text = [self.stops objectAtIndex:indexPath.row];
    
    return cell;
}

@end
