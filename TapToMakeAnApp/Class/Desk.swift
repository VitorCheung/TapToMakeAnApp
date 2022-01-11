//
//  Desk.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 10/01/22.
//

import SpriteKit

public class Desk: SKSpriteNode{
    public init(){
        let texture = SKTexture(imageNamed: "desk.png")
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        name="desk"
        self.zPosition = 2
        self.scale(to: CGSize(width: 102, height: 102))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}