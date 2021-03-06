//
//  BLDrawerViewController.h
//  Flightplan
//
//  Created by William Chen on 8/5/14.
//  Copyright (c) 2014 Brewliant Labs. All rights reserved.
//

#import "BLViewController.h"

extern const CGFloat BLkDrawerWidth;

@interface BLDrawerViewController : BLViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *dataSource;
@property (strong, nonatomic) UITableView *tableView;
@end
