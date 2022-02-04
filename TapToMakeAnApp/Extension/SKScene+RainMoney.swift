//
//  SKScene+RainMoney.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 19/01/22.
//

import Foundation
import SpriteKit

extension SKScene {
    
    func rainMoney(CGpositon: CGPoint){
        let MoneyNode1 = SKSpriteNode(imageNamed: "Money")
        MoneyNode1.setScale(0.5)
        MoneyNode1.physicsBody = SKPhysicsBody()
        MoneyNode1.zPosition = 5
        MoneyNode1.position = CGpositon
        addChild(MoneyNode1)
        MoneyNode1.run(
        SKAction.rotate(byAngle: 2, duration: 1),
        completion: MoneyNode1.removeFromParent)
        MoneyNode1.physicsBody?.applyImpulse(CGVector(dx: Int.random(in: -200...200), dy: Int.random(in: 100...600)))
    }
}
