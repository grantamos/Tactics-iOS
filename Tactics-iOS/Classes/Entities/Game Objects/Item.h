//
//  Item.h
//  Tactics-iOS
//
//  Created by Bret Wood on 6/22/14.
//  Copyright (c) 2014 SomethingCool. All rights reserved.
//

#import "GameObject.h"

@interface Item : GameObject

// This may change from UIImage to something else. It's kind of just here to give an idea of what it is
@property (strong, nonatomic) UIImage *icon;
// This may end up being promoted to GameObject
@property (strong, nonatomic) NSString *name;

@end
