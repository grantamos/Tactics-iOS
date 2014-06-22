//
//  HexagonGeometry.m
//  tactics-ios
//
//  Created by Amos, Grant ext (E IT S MCC) on 6/19/14.
//  Copyright (c) 2014 SomethingCool. All rights reserved.
//

#import "HexagonFactory.h"
#import "Hexagon.h"
#import "CC3Mesh.h"
#import "CC3MeshNode.h"
#import "CC3VertexArrays.h"

@interface HexagonFactory()

@property (strong, nonatomic) CC3VertexLocations *vertexLocations;
@property (strong, nonatomic) CC3VertexNormals *vertexNormals;
@property (strong, nonatomic) CC3VertexIndices *vertexIndices;
@property (strong, nonatomic) CC3VertexTextureCoordinates *textureCoordinates;

@end

@implementation HexagonFactory

- (CC3VertexLocations*)vertexLocations
{
    if (_vertexLocations == nil)
    {
        _vertexLocations = [CC3VertexLocations vertexArrayWithName: @"HexagonVertices"];
        _vertexLocations.vertexCount = _hexagon_vertex_count;
        _vertexLocations.vertices = _hexagon_vertices;
    }
    
    return _vertexLocations;
}

- (CC3VertexNormals*)vertexNormals
{
    if (_vertexNormals == nil)
    {
        _vertexNormals = [CC3VertexNormals vertexArrayWithName:@"HexagonNormals"];
        _vertexNormals.vertexCount = _hexagon_normal_count;
        _vertexNormals.vertices = _hexagon_normals;
    }
    
    return _vertexNormals;
}

- (CC3VertexIndices*)vertexIndices
{
    if (_vertexIndices == nil)
    {
        _vertexIndices = [CC3VertexIndices vertexArrayWithName:@"HexagonIndices"];
        _vertexIndices.vertexCount = _hexagon_index_count;
        _vertexIndices.vertices = _hexagon_vertices;
    }
    
    return _vertexIndices;
}

- (CC3VertexTextureCoordinates*)textureCoordinates
{
    if (_textureCoordinates == nil)
    {
        _textureCoordinates = [CC3VertexTextureCoordinates vertexArrayWithName:@"HexagonTextureCoordinates"];
        _textureCoordinates.vertexCount = _hexagon_texture_coord_count;
        _textureCoordinates.vertices = _hexagon_texture_coords;
    }
    
    return _textureCoordinates;
}

- (CC3Mesh*)createMesh
{
    CC3Mesh* mesh = [CC3Mesh meshWithName:@"HexagonFactory"];
    
	mesh.shouldInterleaveVertices = NO;
	mesh.vertexLocations = self.vertexLocations;
	mesh.vertexNormals = self.vertexNormals;
	mesh.vertexIndices = self.vertexIndices;
    mesh.vertexTextureCoordinates = self.textureCoordinates;
    
	return mesh;
}

- (CC3MeshNode*)createNode
{
    CC3Mesh *mesh = [self createMesh];
    CC3MeshNode *node = [CC3MeshNode nodeWithName:@"Hexagon"];
    
    node.mesh = mesh;
    
    return node;
}

- (CC3MeshNode*)createNodeWidthRadius:(float)radius height:(float)height
{
    CC3MeshNode *node = [self createNode];
    
    //TODO update Hexagon.h to be a radius of 1 (as opposed to 2)
    node.scale = cc3v(height / 2, radius / 2, radius / 2);
    
    return node;
}

static HexagonFactory* _factory = nil;

+ (HexagonFactory*)factory
{
	if (!_factory) _factory = [self new];
	return _factory;
}

+ (void)deleteFactory
{
	_factory = nil;
}

@end
