//
//  BLDrawerViewController.h
//  Flightplan
//
//  Created by William Chen on 8/5/14.
//  Copyright (c) 2014 Brewliant Labs. All rights reserved.
//

#import "BLViewController.h"
#import "BLNavSection.h"

extern const CGFloat BLkDrawerWidth;

typedef NS_ENUM(NSInteger, BLDrawerItemType)
{
    BLDrawerItemTypeLabel,
    BLDrawerItemTypeLink,
    BLDrawerItemTypeStatus
};

@interface BLDrawerViewController : BLViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *dataSource;
@property (strong, nonatomic) UITableView *tableView;
@end
