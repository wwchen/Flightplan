//
//  BLDrawerViewController.m
//  Flightplan
//
//  Created by William Chen on 8/5/14.
//  Copyright (c) 2014 Brewliant Labs. All rights reserved.
//

#import "BLDrawerViewController.h"

@interface BLDrawerViewController ()

@end

@implementation BLDrawerViewController

- (void)contentSizeDidChange:(NSString *)size
{
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];

    [self.tableView setBackgroundColor:[UIColor blueColor]];
    [self.view setBackgroundColor:[UIColor brownColor]];
    
    [self.view addSubview:self.tableView];
}

# pragma mark - Table View configuration
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataSource count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.dataSource objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    NSArray *section = [self.dataSource objectAtIndex:indexPath.section];
    [cell.textLabel setText:[section objectAtIndex:indexPath.row]];
    return cell;
}

@end
