//
//  File.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 10/01/22.
//

import SpriteKit

public class Window: SKSpriteNode{
    public init(){
        let texture = SKTexture(imageNamed: "window.png")
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        name="window"
        self.scale(to: CGSize(width: 124, height: 124))
        self.zPosition = -1 
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
