//
//  VVStop.h
//  Vandy Vans
//
//  Created by Seth Friedman on 12/10/13.
//  Copyright (c) 2013 VandyApps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VVStop : NSObject

@property (nonatomic, readonly, copy) NSString *name;
@property (nonatomic, readonly, copy) NSString *stopID;
@property (nonatomic, readonly, copy) NSArray *routes;

- (instancetype)initWithID:(NSString *)stopID;

+ (instancetype)stopWithID:(NSString *)stopID;

@end
