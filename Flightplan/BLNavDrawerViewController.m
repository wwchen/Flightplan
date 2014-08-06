//
//  BLNavDrawerViewController.m
//  Flightplan
//
//  Created by William Chen on 8/5/14.
//  Copyright (c) 2014 Brewliant Labs. All rights reserved.
//

#import "BLNavDrawerViewController.h"
#import "BLNavItem.h"

@interface BLNavDrawerViewController ()

@end

@implementation BLNavDrawerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSMutableArray *sections = [[NSMutableArray alloc] init];
    
    BLNavSection *section = [[BLNavSection alloc] init];
    BLNavItem *item = [[BLNavItem alloc] init];
    item.title = @"Home";
    [section.items addObject:item];
    
    item = [[BLNavItem alloc] init];
    item.valueType = BLDrawerItemTypeLabel;
    item.title = @"Settings";
    [section.items addObject:item];
    
    item = [[BLNavItem alloc] init];
    item.valueType = BLDrawerItemTypeLink;
    item.title = @"Bar";
    [section.items addObject:item];
    
    [sections addObject:section];
    
    
    section = [[BLNavSection alloc] init];
    item = [[BLNavItem alloc] init];
    item.title = @"About";
    [section.items addObject:item];
    
    item = [[BLNavItem alloc] init];
    item.valueType = BLDrawerItemTypeLabel;
    item.title = @"Foo";
    [section.items addObject:item];
    
    item = [[BLNavItem alloc] init];
    item.valueType = BLDrawerItemTypeLabel;
    item.title = @"Goo";
    [section.items addObject:item];
    
    [sections addObject:section];
    self.dataSource = [NSArray arrayWithArray:sections];
}

@end
