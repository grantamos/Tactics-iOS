//
//  BaseObject.h
//  Tactics-iOS
//
//  Created by Bret Wood on 6/22/14.
//  Copyright (c) 2014 SomethingCool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CC3Node.h"
#import "Component.h"

@interface GameObject : NSObject

/**
 Follow the component pattern. An object has components that do the heavy lifting. This way, logic for seperate things can be kept apart from each other.
 
 Components include physics, rendering, relationships, and more.
 
 @see http://gameprogrammingpatterns.com/component.html
 */
@property (strong, readonly, nonatomic) NSMutableArray *components;

/**
 The heartbeat of the game object. Every game object that receives a call to the update method will update all of its components.
 */
- (void)update:(float)timeDelta;

/**
 Adds a component to this game object and notifies other managed components.
 
 @param aComponent
    The component to add.
 */
- (void)addComponent:(id<Component>)aComponent;

- (void)removeComponent:(id<Component>)aComponent;

- (id<Component>)componentOfType:(Class)type;

@end
