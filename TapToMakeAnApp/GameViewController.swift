//
//  GameViewController.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 07/01/22.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            let scene = GameSceneOffice()
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFit
                // Set scene to phone size
                scene.size = CGSize(width: 428 , height: 840)
            
                scene.backgroundColor = .white
                // Present the scene
                view.presentScene(scene)

            
            
            view.ignoresSiblingOrder = true

            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
