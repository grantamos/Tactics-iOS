//
//  Character.h
//  Tactics-iOS
//
//  Created by Bret Wood on 6/22/14.
//  Copyright (c) 2014 SomethingCool. All rights reserved.
//

#import "GameObject.h"
#import "EquipmentComponent.h"
#import "StatComponent.h"

@interface Character : GameObject

@property NSInteger currentHealth;
@property NSInteger currentEnergy;

@end
