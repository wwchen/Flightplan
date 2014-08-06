//
//  BLCenterViewController.m
//  Flightplan
//
//  Created by William Chen on 8/5/14.
//  Copyright (c) 2014 Brewliant Labs. All rights reserved.
//

#import "BLCenterViewController.h"
#import <MMDrawerController/UIViewController+MMDrawerController.h>
#import <MMDrawerController/MMDrawerBarButtonItem.h>

@interface BLCenterViewController ()

@end

@implementation BLCenterViewController

- (void)viewDidLoad
{
    MMDrawerBarButtonItem* button = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(drawerButtonPress:)];
    [self.navigationItem setLeftBarButtonItem:button animated:YES];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    [doubleTap setNumberOfTapsRequired:2];
    [self.view addGestureRecognizer:doubleTap];
    
    UIColor *barColor = [UIColor brownColor];
    [self.navigationController.navigationBar setBarTintColor:barColor];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)drawerButtonPress:(id)sender
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)doubleTap:(UITapGestureRecognizer *)gesture
{
    [self.mm_drawerController bouncePreviewForDrawerSide:MMDrawerSideLeft completion:nil];
}

@end
