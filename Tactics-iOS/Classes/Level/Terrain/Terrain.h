//
//  Terrain.h
//  Tactics-iOS
//
//  Created by Amos, Grant ext (E IT S MCC) on 6/22/14.
//  Copyright (c) 2014 SomethingCool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CC3Node.h"

@interface Terrain : CC3Node

- (id)initWithWidth:(int)width height:(int)height andMap:(int**)map;

@end
