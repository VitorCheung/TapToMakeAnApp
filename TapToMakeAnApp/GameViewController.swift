//
//  GameViewController.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 07/01/22.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Player.shared = Player.getPlayerUserDefaults()
        Player.shared.verifyData()
//        Player.shared.money = 0
//        Player.shared.workers = []
//        Player.shared.team = [nil,nil,nil]
//        Player.shared.apps = []
//        Player.shared.docsBuy = 0
//        Player.shared.upgrades = [
//            Upgrade(name: "Upgrade PC", scalePrice: 250, description: "+1 power for\nyou click"),
//            Upgrade(name: "Air Conditioner", scalePrice: 500, description: "+1 day to your\ndeadLine"),
//            Upgrade(name: "Wifi", scalePrice: 1000, description: "incrise your\nearning by 1.25 "),
//            Upgrade(name: "Coffe", scalePrice: 2000, description: "incrise your value\nof apps by 1.50 "),
//            Upgrade(name: "Server", scalePrice: 4000, description: "+1 app to store")
//        ]
        

        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            let scene = GameSceneOffice()
                // Present the scene
                view.presentScene(scene)
            
            view.ignoresSiblingOrder = true

//            view.showsFPS = true
//            view.showsNodeCount = true
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
