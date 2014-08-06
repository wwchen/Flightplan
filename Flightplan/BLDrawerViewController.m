//
//  BLDrawerViewController.m
//  Flightplan
//
//  Created by William Chen on 8/5/14.
//  Copyright (c) 2014 Brewliant Labs. All rights reserved.
//

#import "BLDrawerViewController.h"
#import <MMDrawerController/UIViewController+MMDrawerController.h>

const CGFloat BLkDrawerWidth = 140.0f;

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
    BLNavSection *navSection = [self.dataSource objectAtIndex:section];
    return [navSection.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    BLNavSection *navSection = [self.dataSource objectAtIndex:indexPath.section];
    BLNavItem *navItem = [navSection.items objectAtIndex:indexPath.row];
    // TODO temporarily just show the textlabel
    [cell.textLabel setText:[navItem title]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected %@", indexPath);
    //[self.mm_drawerController closeDrawerAnimated:YES completion:nil];
    UIViewController *nav = [[UIViewController alloc] init];
    [self.mm_drawerController setCenterViewController:nav withCloseAnimation:YES completion:nil];
}

@end
