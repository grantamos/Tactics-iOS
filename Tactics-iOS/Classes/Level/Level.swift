//
//  Level.swift
//  tactics-ios
//
//  Created by Amos, Grant ext (E IT S MCC) on 6/19/14.
//  Copyright (c) 2014 SomethingCool. All rights reserved.
//

import Foundation
import SceneKit

class Level {
    
    class func GenerateLevel() -> LevelScene {
        let scene = LevelScene()
        
        // create and add a light to the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light.type = SCNLightTypeOmni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        scene.rootNode.addChildNode(lightNode)
        
        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light.type = SCNLightTypeAmbient
        ambientLightNode.light.color = UIColor.lightGrayColor()
        scene.rootNode.addChildNode(ambientLightNode)
        
        //Generate level
        let automata: Automata = Automata(width: 16, height: 16, iterations: 1, killAmount: 1, andGrowAmount: 3)
        var map: Int[][] = automata.createBoxedAutomata() as Int[][]
        
        let terrain = Terrain(width: 16, height: 16, map: map)
        
        scene.rootNode.addChildNode(terrain)
        
        return scene
    }
}