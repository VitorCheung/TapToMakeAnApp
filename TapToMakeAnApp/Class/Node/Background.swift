//
//  Background.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 10/01/22.
//

import SpriteKit

public class Background: SKSpriteNode{
    public init(){
        let texture = SKTexture(imageNamed: "background")
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        name="background"
        self.zPosition = -1
        self.scale(to: CGSize(width: 428, height: 125))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
