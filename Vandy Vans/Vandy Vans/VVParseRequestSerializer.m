//
//  VVParseRequestSerializer.m
//  Vandy Vans
//
//  Created by Seth Friedman on 8/16/14.
//  Copyright (c) 2014 VandyApps. All rights reserved.
//

#import "VVParseRequestSerializer.h"

@implementation VVParseRequestSerializer

- (instancetype)init {
    self = [super init];
    
    if (self) {
        [self setValue:@"5hqxAmsC7YKdgx90ocqmwSGwwCzmoje6V6IYYdZE"
    forHTTPHeaderField:@"X-Parse-Application-Id"];
        [self setValue:@"VyKkdzfaxkhUEvhZU3rD4YR5vkELgBSqU0g5uixu"
    forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    }
    
    return self;
}

@end
