//
//  BLViewController.m
//  Flightplan
//
//  Created by William Chen on 8/5/14.
//  Copyright (c) 2014 Brewliant Labs. All rights reserved.
//

#import "BLViewController.h"

@interface BLViewController ()

@end

@implementation BLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(contentSizeDidChange:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)contentSizeDidChange:(NSString *)size
{
    // implemented by subclasses
}

@end
