//
//  EquipmentComponent.h
//  Tactics-iOS
//
//  Created by Bret Wood on 6/22/14.
//  Copyright (c) 2014 SomethingCool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Component.h"
#import "Item.h"

@interface EquipmentComponent : NSObject <Component>

@property (strong, nonatomic) NSMutableArray *equipment;

- (BOOL)equipItem:(Item *)item;

@end
