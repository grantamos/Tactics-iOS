//
//  LevelViewController.swift
//  tactics-ios
//
//  Created by Amos, Grant ext (E IT S MCC) on 6/20/14.
//  Copyright (c) 2014 SomethingCool. All rights reserved.
//

import Foundation

class LevelViewController: UIViewController {
    
    var levelScene: LevelScene
    
    init(coder aDecoder: NSCoder!)  {
        //Generate a random scene
        levelScene = Level.GenerateLevel()
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // retrieve the SCNView
        let scnView = self.view as SCNView
        
        // set the scene to the view
        scnView.scene = levelScene
        
        // show statistics such as fps and timing information
        scnView.showsStatistics = true
        
        // configure the view
        scnView.backgroundColor = UIColor.blackColor()
        
        // add a tap gesture recognizer
        let rotateGesture = UIPanGestureRecognizer(target: self, action: "rotate:")
        rotateGesture.minimumNumberOfTouches = 1
        rotateGesture.maximumNumberOfTouches = 1
        let panGesture = UIPanGestureRecognizer(target: self, action: "pan:")
        panGesture.minimumNumberOfTouches = 2
        panGesture.maximumNumberOfTouches = 2
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: "pinch:")
        
        let gestureRecognizers = [rotateGesture, panGesture, pinchGesture]
        scnView.gestureRecognizers = gestureRecognizers
    }
    
    func pan(gesture: UIPanGestureRecognizer) {
        
        var translation = gesture.translationInView(self.view)
        
        levelScene.translateCamera(Float(translation.x), y: Float(translation.y))
    }
    
    func rotate(gesture: UIPanGestureRecognizer) {
        var translation = gesture.translationInView(self.view)
        
        levelScene.rotateCamera(translation.x, y: translation.y)
        /*
        var eulerAngles = cameraHandle.eulerAngles
        eulerAngles.y += translation.x * -0.01
        eulerAngles.x += translation.y * -0.01
        eulerAngles.z = 0;
        
        cameraHandle.eulerAngles = eulerAngles
*/
    }
    
    func pinch(gesture: UIPinchGestureRecognizer) {
        /*
        if(gesture.state == UIGestureRecognizerState.Began) {
            previousScale = gesture.scale
        }
        
        var scale = 1 - (previousScale - gesture.scale)
        
        var position = cameraNode.position
        position.z *= scale
        
        if position.z < 1 {
            position.z = 1
        }
        
        cameraNode.position = position
*/
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.toRaw())
        } else {
            return Int(UIInterfaceOrientationMask.All.toRaw())
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
}