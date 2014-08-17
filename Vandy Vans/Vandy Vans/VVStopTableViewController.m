//
//  VVArrivalTimeTableViewController.m
//  Vandy Vans
//
//  Created by Seth Friedman on 10/11/12.
//  Copyright (c) 2012 VandyApps. All rights reserved.
//

#import "VVStopTableViewController.h"
#import "VVArrivalTimeTableViewController.h"
#import "VVStop.h"

@interface VVStopTableViewController ()

@property (strong, nonatomic) NSArray *stops;

@end

@implementation VVStopTableViewController

- (NSArray *)stops {
    if (!_stops) {
        if ([self.title isEqualToString:@"Stops"]) {
            _stops = @[[VVStop stopWithID:@"263473"], // Branscomb
                       [VVStop stopWithID:@"263470"], // Towers
                       [VVStop stopWithID:@"644903"], // Hank Ingram
                       [VVStop stopWithID:@"644872"], // Kissam
                       [VVStop stopWithID:@"263444"], // Highland
                       @"Other Stops"];
        } else {
            _stops = @[[VVStop stopWithID:@"264041"], // VUPD
                       [VVStop stopWithID:@"332298"], // Book Store
                       [VVStop stopWithID:@"644873"], // Terrace Place
                       [VVStop stopWithID:@"238096"], // Wesley
                       [VVStop stopWithID:@"263463"], // North
                       [VVStop stopWithID:@"264091"], // Blair
                       [VVStop stopWithID:@"264101"], // McGugin
                       [VVStop stopWithID:@"644874"]]; // MRB 3
        }
    }
    
    return _stops;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarItem.selectedImage = [UIImage imageNamed:@"target-selected"];
    
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"VVBackground"]];
    
    // If the title has not yet been set, it is the Stops view, not the Other Stops view.
    if (!self.title) {
        self.title = @"Stops";
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.barStyle = UIBarStyleBlack;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    self.stops = nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"StopsToArrivalTimes"]) {
        NSInteger row = [self.tableView indexPathForCell:sender].row;
        [segue.destinationViewController setSelectedStop:self.stops[row]];
    } else if ([segue.identifier isEqualToString:@"StopsToOtherStops"]) {
        ((VVStopTableViewController *)segue.destinationViewController).title = @"Other Stops";
    }
}

#pragma mark - IB Action

- (IBAction)aboutViewDismissed:(UIStoryboardSegue *)segue {
    [UIView transitionWithView:self.navigationController.view
                      duration:0.75
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:nil
                    completion:nil];
}

#pragma mark - Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.stops count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Stop";
    static NSString *OtherCellIdentifier = @"OtherStops";
    UITableViewCell *cell;
    
    NSInteger row = indexPath.row;
    
    if ([self.title isEqualToString:@"Stops"]) {
        // If this is the Stops table view, check to see which cell is being retrieved. If it is not the last one, return
        // a normal stop cell. If it is, return the cell for "Other Stops".
        cell = (row != ([self.stops count] - 1)) ? [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath] : [tableView dequeueReusableCellWithIdentifier:OtherCellIdentifier forIndexPath:indexPath];
        
        if (row != [self.stops count] - 1) {
            VVStop *stop = self.stops[row];
            cell.textLabel.text = stop.name;
        } else {
            // "Other Stops"
            cell.textLabel.text = self.stops[row];
        }
    } else {
        // If it is not the Stops table view, just return the next cell as normal.
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        VVStop *stop = self.stops[row];
        cell.textLabel.text = stop.name;
    }
    
    return cell;
}

@end
