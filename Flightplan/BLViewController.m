//
//  BLViewController.m
//  Flightplan
//
//  Created by William Chen on 8/5/14.
//  Copyright (c) 2014 Brewliant Labs. All rights reserved.
//

#import "BLViewController.h"

@interface BLViewController ()
- (void)contentSizeDidChangeNotification:(NSNotification *)notification;
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

- (void)contentSizeDidChangeNotification:(NSNotification *)notification
{
    [self contentSizeDidChange:notification.userInfo[UIContentSizeCategoryNewValueKey]];
}

- (void)contentSizeDidChange:(NSString *)size
{
    // implemented by subclasses
    NSLog(@"content size changed to %@", size);
}

@end
