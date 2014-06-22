//
//  HexagonGeometry.h
//  tactics-ios
//
//  Created by Amos, Grant ext (E IT S MCC) on 6/19/14.
//  Copyright (c) 2014 SomethingCool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CC3Mesh.h"
#import "CC3MeshNode.h"

@interface HexagonFactory : NSObject

- (CC3Mesh*)createMesh;
- (CC3MeshNode*)createNode;
- (CC3MeshNode*)createNodeWidthRadius:(float)radius height:(float)height;

/** Returns the singleton instance. */
+ (HexagonFactory*)factory;

/** Deletes the factory singleton, to clear items from memory. */
+ (void)deleteFactory;

@end
