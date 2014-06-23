//
//  Component.h
//  Tactics-iOS
//
//  Created by Bret Wood on 6/22/14.
//  Copyright (c) 2014 SomethingCool. All rights reserved.
//

#import "GameObject.h"

@protocol Component <NSObject>

@optional
- (void)update:(GameObject *)object withDelta:(float)timeDelta;

@optional
- (void)containerAddedComponent:(id<Component>)Component;

@end