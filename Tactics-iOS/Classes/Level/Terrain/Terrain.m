//
//  Terrain.m
//  Tactics-iOS
//
//  Created by Amos, Grant ext (E IT S MCC) on 6/22/14.
//  Copyright (c) 2014 SomethingCool. All rights reserved.
//

#import "Terrain.h"
#import "HexagonFactory.h"

#import "CC3Mesh.h"
#import "CC3Material.h"
#import "CC3Texture.h"
#import "CC3Node.h"

@interface Terrain() {
    int _width;
    int _height;
    int **_map;
}

@end

@implementation Terrain

- (id)initWithWidth:(int)width height:(int)height andMap:(int**)map
{
    self = [super init];
    
    if (self)
    {
        _width = width;
        _height = height;
        _map = map;
        
        [self setup];
    }
    
    return self;
}

- (void)dealloc
{
    free(_map);
}

- (void)setup
{
    float height = 0.5;
    float radius = 1.0;
    float hexHeight = 2 * radius;
    float rowHeight = 1.5 * radius;
    float halfWidth = sqrt((radius * radius) - (radius / 2) * (radius / 2));
    float hexWidth = 2 * halfWidth;
    float extraWidth = hexHeight - rowHeight;
    
    CC3Texture *texture = [CC3Texture textureFromFile:@"Hex256.png"];
    
    for (int x = 0; x < _width; x++)
    {
        for (int y = 0; y < _height; y++)
        {
            CC3Node *hexNode = [HexagonFactory.factory
                                createNodeWidthRadius:radius
                                height:height];
            
            float xPos = x * hexWidth + ((y & 1) * halfWidth);
            float yPos = y * rowHeight;
            
            hexNode.location = cc3v(xPos, 0, yPos);
            //hexNode.texture = texture;
            hexNode.diffuseColor = ccc4f(0.8, 0.8, 0.8, 1.0);
            
            [self addChild:hexNode];
        }
    }
}

@end
