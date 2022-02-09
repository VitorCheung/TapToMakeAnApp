//
//  Desk.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 10/01/22.
//

import SpriteKit

public class DeskNode: SKSpriteNode{
    public init(){
        let texture = SKTexture(imageNamed: "desk.png")
        super.init(texture: texture, color: UIColor.clear, size: CGSize(width: 102, height: 102))
        name="desk"
        self.zPosition = 5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
