//
//  BLDrawerItem.h
//  Flightplan
//
//  Created by William Chen on 8/6/14.
//  Copyright (c) 2014 Brewliant Labs. All rights reserved.
//

typedef NS_ENUM(NSInteger, BLDrawerItemType)
{
    BLDrawerItemTypeLabel,
    BLDrawerItemTypeLink,
    BLDrawerItemTypeStatus
};

@interface BLDrawerItem : NSObject

- (id)initWithLabel:(NSString *)label valueType:(BLDrawerItemType)valueType value:(id)value;
@property (strong, nonatomic) NSString *label;
@property (nonatomic) BLDrawerItemType valueType;
@property (strong, nonatomic) id value;

@end
