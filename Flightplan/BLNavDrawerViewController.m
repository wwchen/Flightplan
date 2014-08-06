//
//  BLNavDrawerViewController.m
//  Flightplan
//
//  Created by William Chen on 8/5/14.
//  Copyright (c) 2014 Brewliant Labs. All rights reserved.
//

#import "BLNavDrawerViewController.h"
#import "BLDrawerSection.h"
#import "BLDrawerItem.h"

@interface BLNavDrawerViewController ()

@end

@implementation BLNavDrawerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSMutableArray *sections = [[NSMutableArray alloc] init];
    
    BLDrawerSection *section = [[BLDrawerSection alloc] init];
    BLDrawerItem *item = [[BLDrawerItem alloc] init];
    item.title = @"Home";
    [section.items addObject:item];
    
    item = [[BLDrawerItem alloc] init];
    item.valueType = BLDrawerItemTypeLabel;
    item.title = @"Settings";
    [section.items addObject:item];
    
    item = [[BLDrawerItem alloc] init];
    item.valueType = BLDrawerItemTypeLink;
    item.title = @"Bar";
    [section.items addObject:item];
    
    [sections addObject:section];
    
    
    section = [[BLDrawerSection alloc] init];
    item = [[BLDrawerItem alloc] init];
    item.title = @"About";
    [section.items addObject:item];
    
    item = [[BLDrawerItem alloc] init];
    item.valueType = BLDrawerItemTypeLabel;
    item.title = @"Foo";
    [section.items addObject:item];
    
    item = [[BLDrawerItem alloc] init];
    item.valueType = BLDrawerItemTypeLabel;
    item.title = @"Goo";
    [section.items addObject:item];
    
    [sections addObject:section];
    self.dataSource = [NSArray arrayWithArray:sections];
}

@end
