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
    BLDrawerItem *item = [[BLDrawerItem alloc] initWithLabel:@"Home" valueType:BLDrawerItemTypeLabel value:nil];
    [section.items addObject:item];
    
    item = [[BLDrawerItem alloc] initWithLabel:@"Settings" valueType:BLDrawerItemTypeLink value:nil];
    [section.items addObject:item];
    
    item = [[BLDrawerItem alloc] initWithLabel:@"Bar" valueType:BLDrawerItemTypeLabel value:nil];
    [section.items addObject:item];
    
    [sections addObject:section];
    
    
    section = [[BLDrawerSection alloc] init];
    item = [[BLDrawerItem alloc] initWithLabel:@"About" valueType:BLDrawerItemTypeLabel value:nil];
    [section.items addObject:item];
    
    item = [[BLDrawerItem alloc] initWithLabel:@"Foo" valueType:BLDrawerItemTypeLabel value:nil];
    [section.items addObject:item];
    
    item = [[BLDrawerItem alloc] initWithLabel:@"Goo" valueType:BLDrawerItemTypeLabel value:nil];
    [section.items addObject:item];
    
    [sections addObject:section];
    self.dataSource = [NSArray arrayWithArray:sections];
}

@end
