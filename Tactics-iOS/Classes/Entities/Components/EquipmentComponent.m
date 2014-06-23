//
//  EquipmentComponent.m
//  Tactics-iOS
//
//  Created by Bret Wood on 6/22/14.
//  Copyright (c) 2014 SomethingCool. All rights reserved.
//

#import "EquipmentComponent.h"

@implementation EquipmentComponent

- (BOOL)equip:(Item *)item
{
    [self.equipment addObject:item];
}

@end
