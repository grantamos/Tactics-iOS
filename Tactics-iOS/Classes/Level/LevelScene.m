//
//  LevelScene.m
//  Tactics-iOS
//
//  Created by Amos, Grant ext (E IT S MCC) on 6/22/14.
//  Copyright (c) 2014 SomethingCool. All rights reserved.
//

#import "LevelScene.h"
#import "Automata.h"
#import "Terrain.h"

#import "CC3PODResourceNode.h"
#import "CC3ActionInterval.h"
#import "CC3MeshNode.h"
#import "CC3Camera.h"
#import "CC3Light.h"
#import "CC3UtilityMeshNodes.h"

@implementation LevelScene

- (void)initializeScene
{
    // Create the camera, place it back a bit, and add it to the scene
	CC3Camera* cam = [CC3Camera nodeWithName: @"Camera"];
	cam.location = cc3v( 0.0, 0.0, 100.0 );
	[self addChild:cam];
    
    // create and add a light to the scene
    CC3Light *directionalLight = [CC3Light
                                  nodeWithName:@"DirectionalLight"];
    directionalLight.isDirectionalOnly = YES;
    directionalLight.location = cc3v(0.0, 10.0, 10.0);
    [self addChild:directionalLight];
    
    // Setup global illumination??
    
    //Generate level
    Automata *automata = [[Automata alloc] initWithWidth:1
                                                  height:1
                                              iterations:1
                                              killAmount:1
                                           andGrowAmount:3];
    
    int **map = [automata createAutomata2DArray];
    
    Terrain *terrain = [[Terrain alloc] initWithWidth:1 height:1 andMap:map];
    
    [self addChild:terrain];
    
    [self selectShaders];
    [self setOpacity:kCCOpacityFull];
    
    [self createBoundingVolumes];
	[self createGLBuffers];
	[self releaseRedundantContent];
    
	
	// ------------------------------------------
	
	// That's it! The scene is now constructed and is good to go.
	
	// To help you find your scene content once it is loaded, the onOpen method below contains
	// code to automatically move the camera so that it frames the scene. You can remove that
	// code once you know where you want to place your camera.
	
	// If you encounter problems displaying your models, you can uncomment one or more of the
	// following lines to help you troubleshoot. You can also use these features on a single node,
	// or a structure of nodes. See the CC3Node notes for more explanation of these properties.
	// Also, the onOpen method below contains additional troubleshooting code you can comment
	// out to move the camera so that it will display the entire scene automatically.
	
	// Displays short descriptive text for each node (including class, node name & tag).
	// The text is displayed centered on the pivot point (origin) of the node.
    self.shouldDrawAllDescriptors = YES;
	
	// Displays bounding boxes around those nodes with local content (eg- meshes).
    self.shouldDrawAllLocalContentWireframeBoxes = YES;
	
	// Displays bounding boxes around all nodes. The bounding box for each node
	// will encompass its child nodes.
    self.shouldDrawAllWireframeBoxes = YES;
	
	// If you encounter issues creating and adding nodes, or loading models from
	// files, the following line is used to log the full structure of the scene.
	LogInfo(@"The structure of this scene is: %@", [self structureDescription]);
	
	[terrain runAction: [CC3ActionRotateForever actionWithRotationRate: cc3v(10, 30, 0)]];
}

#pragma mark Scene opening and closing

- (void)onOpen
{
	[self.activeCamera moveWithDuration: 3.0 toShowAllOf: self withPadding: 0.5f];
    
    self.shouldDrawWireframeBox = YES;
}

@end
