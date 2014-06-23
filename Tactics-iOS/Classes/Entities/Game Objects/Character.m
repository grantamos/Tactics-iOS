//
//  Character.m
//  Tactics-iOS
//
//  Created by Bret Wood on 6/22/14.
//  Copyright (c) 2014 SomethingCool. All rights reserved.
//

#import "Character.h"

@implementation Character

- (instancetype)init
{
    self = [super init];
    if (self) {
        // Add physics, graphics, equipment components
        [self addComponent:[[EquipmentComponent alloc] init]];
        [self addComponent:[[StatComponent alloc] init]];
    }
    return self;
}

@end
