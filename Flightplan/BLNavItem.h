//
//  BLNavItem.h
//  Flightplan
//
//  Created by William Chen on 8/6/14.
//  Copyright (c) 2014 Brewliant Labs. All rights reserved.
//

typedef NS_ENUM(NSInteger, BLNavItemType)
{
    BLNavItemTypeLabel,
    BLNavItemTypeLink,
    BLNavItemTypeStatus
};

@interface BLNavItem : NSObject

@property (strong, nonatomic) NSString *title;
@property (nonatomic) NSInteger valueType;
@property (strong, nonatomic) id value;

@end