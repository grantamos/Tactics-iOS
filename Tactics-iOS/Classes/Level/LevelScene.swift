//
//  LevelScene.swift
//  tactics-ios
//
//  Created by Amos, Grant ext (E IT S MCC) on 6/20/14.
//  Copyright (c) 2014 SomethingCool. All rights reserved.
//

import Foundation

class LevelScene: SCNScene, SCNSceneRendererDelegate {
    
    var cameraHandle: SCNNode
    var cameraNode: SCNNode
    var previousScale: Float = 0.0
    var delta: Float = 0.1
    
    var previousUpdate: NSTimeInterval = 0
    
    func setupCamera() {
        cameraNode.name = "CameraNode"
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 10)
        
        cameraHandle.addChildNode(cameraNode)
        
        self.rootNode.addChildNode(cameraHandle)
        cameraHandle.position = SCNVector3(x: 8, y: 5, z: 8)
    }
    
    init() {
        cameraHandle = SCNNode()
        cameraNode = SCNNode()
        
        super.init()
        
        self.setupCamera()
    }
    
    init(coder aDecoder: NSCoder!) {
        cameraHandle = SCNNode()
        cameraNode = SCNNode()
        
        super.init(coder: aDecoder)
        
        self.setupCamera()
    }

    /*
    override func renderer(aRenderer: SCNSceneRenderer!, updateAtTime time: NSTimeInterval) {
        if (previousUpdate == 0) {
            previousUpdate = time
        }
        
        delta = Float(time - previousUpdate)
        previousUpdate = time
    }
    */
    func translateCamera(x: Float, y: Float) {
        
        var position = cameraHandle.position
        
        position.x += x * delta
        position.y += y * delta
        
        cameraHandle.position = position
    }
    
    func rotateCamera(x: Float, y: Float) {
        
        var eulerAngles = cameraHandle.eulerAngles
        
        eulerAngles.y += x * -0.01
        eulerAngles.x += y * -0.01
        eulerAngles.z = 0;
        
        cameraHandle.eulerAngles = eulerAngles
    }
}