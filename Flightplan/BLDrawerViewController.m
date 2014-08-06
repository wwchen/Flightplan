//
//  BLDrawerViewController.m
//  Flightplan
//
//  Created by William Chen on 8/5/14.
//  Copyright (c) 2014 Brewliant Labs. All rights reserved.
//

#import "BLDrawerViewController.h"
#import "BLDrawerSection.h"
#import "BLDrawerItem.h"
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
    [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];

    [self.view setBackgroundColor:[UIColor brownColor]];
    
    [self.view addSubview:self.tableView];
}

# pragma mark - Table View configuration
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataSource count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)index
{
    BLDrawerSection *section = [self.dataSource objectAtIndex:index];
    return [section.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    BLDrawerSection *section = [self.dataSource objectAtIndex:indexPath.section];
    BLDrawerItem *item = [section.items objectAtIndex:indexPath.row];
    // TODO temporarily just show the textlabel
    switch ([item valueType]) {
        case BLDrawerItemTypeLabel:
            break;
        case BLDrawerItemTypeLink:
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case BLDrawerItemTypeStatus:
            break;
        default:
            break;
    }
    [cell.textLabel setText:[item label]];
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
