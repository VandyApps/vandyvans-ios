//
//  VVNotificationCell.m
//  Vandy Vans
//
//  Created by Seth Friedman on 3/3/13.
//  Copyright (c) 2013 VandyMobile. All rights reserved.
//

#import "VVNotificationCell.h"

@implementation VVNotificationCell

@synthesize notificationSwitch = _notificationSwitch;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
