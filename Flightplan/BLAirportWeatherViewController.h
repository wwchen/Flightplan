//
//  BLAirportWeatherViewController.h
//  Flightplan
//
//  Created by William Chen on 8/11/14.
//  Copyright (c) 2014 Brewliant Labs. All rights reserved.
//

#import "BLCenterViewController.h"

@interface BLAirportWeatherViewController : BLCenterViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@end
