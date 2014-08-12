//
//  BLAirportWeatherViewController.m
//  Flightplan
//
//  Created by William Chen on 8/11/14.
//  Copyright (c) 2014 Brewliant Labs. All rights reserved.
//

#import "BLAirportWeatherViewController.h"
#import "BLAirportWeatherTableViewCell.h"
#import "BLUtils.h"

@interface BLAirportWeatherViewController ()

@end

@implementation BLAirportWeatherViewController

- (void)viewDidLoad
{
    [super viewDidLoad]; // TODO calling super is needed?
    [self.view setBackgroundColor:[UIColor yellowColor]];
    if (!self.tableView)
    {
        self.tableView = [[UITableView alloc] initWithFrame:[self.view frame]];
        self.dataSource = [[NSMutableArray alloc] init];
        [self.tableView setDataSource:self];
        [self.tableView setDelegate:self];
        [self.tableView setRowHeight:[BLAirportWeatherTableViewCell height]];
        [self.dataSource addObject:@"kpae"];
        [self.view addSubview:self.tableView];
    }
    NSLog(@"viewDidLoad");
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cellForRowAtIndexPath");
    NSString *icao = [self.dataSource objectAtIndex:indexPath.row];
    BLAirportWeatherTableViewCell *cell = [[BLAirportWeatherTableViewCell alloc] initWithICAO:icao];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

@end
