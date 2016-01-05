//
//  GameViewController.swift
//  Sort
//
//  Created by yesh0907 on 2/26/15.
//  Copyright (c) 2015 Yesh Chandiramani. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    var scene:GameScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure the View
        let skView = view as! SKView
        skView.multipleTouchEnabled = false;
        skView.showsFPS = false
        skView.showsNodeCount = false
        
        //Create and configure Scene
        scene = GameScene(size: skView.bounds.size);
        scene.scaleMode = .AspectFill
        
        //Present Scene
        skView.presentScene(scene);
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return UIInterfaceOrientationMask.AllButUpsideDown
        } else {
            return UIInterfaceOrientationMask.All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
