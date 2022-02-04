//
//  ServerNode.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 13/01/22.
//

import SpriteKit

public class ServerNode: SKSpriteNode{
    public init(){
        let texture = SKTexture(imageNamed: "server 0.png")
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        name="server"
        self.zPosition = 5
        self.scale(to: CGSize(width: 120, height: 120))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

