//
//  BaseObject.m
//  Tactics-iOS
//
//  Created by Bret Wood on 6/22/14.
//  Copyright (c) 2014 SomethingCool. All rights reserved.
//

#import "GameObject.h"


@implementation GameObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        _components = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)update:(float)timeDelta
{
    for (id<Component> component in self.components) {
        if ([component respondsToSelector:@selector(update:withDelta:)]) {
            [component update:self withDelta:timeDelta];
        }
    }
}

- (void)addComponent:(id<Component>)aComponent
{
    for (id<Component> component in self.components) {
        [component containerDidAddComponent:newComponent];
    }
    
    [self.components addObject:newComponent];
}

- (void)removeComponent:(id<Component>)aComponent
{
    [self.components removeObject:aComponent];
}

- (id<Component>)componentOfType:(Class)type
{
    for (id<Component> component in self.components) {
        if ([component isKindOfClass:type]) {
            return component;
        }
    }
    return nil;
}

@end
