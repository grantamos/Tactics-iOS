//
//  Terrain.swift
//  tactics-ios
//
//  Created by Amos, Grant ext (E IT S MCC) on 6/19/14.
//  Copyright (c) 2014 SomethingCool. All rights reserved.
//

import Foundation
import SceneKit

class Terrain: SCNNode {
    
    var width: Int
    var height: Int
    var map: Int[][]
    
    init(width: Int, height: Int, map: Int[][]) {
        self.width = width
        self.height = height
        self.map = map
        
        super.init()
        
        var radius = 0.5
        var hexHeight = 2 * radius
        var rowHeight = 1.5 * radius
        var halfWidth = sqrt((radius * radius) - ((radius / 2) * (radius / 2)))
        var hexWidth = 2 * halfWidth
        var extraHeight = hexHeight - rowHeight
        
        //create boxes for hexagons temporarily
        let hexGeometry1 = HexagonGeometry.CreateWithRadius(Float(radius), andHeight: 0.5)
        let hexGeometry2 = HexagonGeometry.CreateWithRadius(Float(radius), andHeight: 1)
        let hexGeometry3 = HexagonGeometry.CreateWithRadius(Float(radius), andHeight: 1.5)
        // create and configure a material
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "Hex256")
        material.locksAmbientWithDiffuse = true
        
        for (x, column) in enumerate(map) {
            for (y, value) in enumerate(column) {
                var hexNode = SCNNode()
                
                hexNode.position.y = 0.0
                hexNode.position.x = Float(x) * Float(hexWidth) + Float((Double(y & 1) * halfWidth))
                hexNode.position.z = Float(y) * Float(rowHeight)
                
                if value == 0 {
                    hexNode.geometry = hexGeometry1
                } else if value == 1 {
                    hexNode.geometry = hexGeometry2
                } else if value == 2 {
                    hexNode.geometry = hexGeometry3
                }
                
                // set the material to the 3d object geometry
                hexNode.geometry.firstMaterial = material
                
                //Add it to the terrain's child nodes
                self.addChildNode(hexNode)
            }
        }
    }
}