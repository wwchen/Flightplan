//
//  BLTableViewCell.m
//  Flightplan
//
//  Created by William Chen on 8/13/14.
//  Copyright (c) 2014 Brewliant Labs. All rights reserved.
//

#import "BLTableViewCell.h"

@implementation BLTableViewCell

+ (NSString *)reuseIdentifer
{
    return NSStringFromClass([self class]);
}

+ (NSString *)nibName
{
    return NSStringFromClass([self class]);
}

@end
