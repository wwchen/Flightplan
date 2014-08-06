//
//  BLDrawerItem.m
//  Flightplan
//
//  Created by William Chen on 8/6/14.
//  Copyright (c) 2014 Brewliant Labs. All rights reserved.
//

#import "BLDrawerItem.h"

@implementation BLDrawerItem

- (id)initWithLabel:(NSString *)label valueType:(BLDrawerItemType)valueType value:(id)value
{
    self = [super init];
    if (self)
    {
        self.label = label;
        self.valueType = valueType;
        self.value = value;
    }
    return self;
}

@end
