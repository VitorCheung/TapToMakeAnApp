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
    
        Player.shared.money=0
        Player.shared.points=0
        Player.shared.workers.append(WorkersEnum.Ju)
        Player.shared.workers.append(WorkersEnum.Muza)
        Player.shared.workers.append(WorkersEnum.Marcus)
        Player.shared.workers.append(WorkersEnum.Marcus)
        Player.shared.workers.append(WorkersEnum.Ju)
        Player.shared.workers.append(WorkersEnum.Muza)
        Player.shared.workers.append(WorkersEnum.Ju)
        Player.shared.workers.append(WorkersEnum.Muza)
        Player.shared.workers.append(WorkersEnum.Ju)
        Player.shared.workers.append(WorkersEnum.Muza)
        Player.shared.workers.append(WorkersEnum.Marcus)
        Player.shared.workers.append(WorkersEnum.Marcus)
        Player.shared.workers.append(WorkersEnum.Ju)
        Player.shared.workers.append(WorkersEnum.Muza)
        Player.shared.workers.append(WorkersEnum.Ju)
        Player.shared.workers.append(WorkersEnum.Muza)
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            let scene = GameSceneOffice()
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
