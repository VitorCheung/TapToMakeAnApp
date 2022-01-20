//
//  infoButton.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 17/01/22.
//
import SpriteKit

public class InfoButton: SKSpriteNode{
    let worker : Worker?
    
    public init(worker:Worker){
        self.worker = worker
        super.init(texture: nil, color: .clear, size: CGSize(width: 25, height: 25))
        self.name = "info"
        self.anchorPoint = CGPoint(x: 0, y: 0)
        self.zPosition = 2
        
        let iconInfo = SKSpriteNode(imageNamed: "infoIcon")
        iconInfo.zPosition = -1
        iconInfo.scale(to: CGSize(width: 22, height: 22))
        iconInfo.position = CGPoint(x:0,y:0)
        iconInfo.anchorPoint = CGPoint(x: 0, y: 0)
        self.addChild(iconInfo)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
