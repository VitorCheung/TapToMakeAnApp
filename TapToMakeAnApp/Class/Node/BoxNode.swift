//
//  BoxNode.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 20/01/22.
//

import Foundation
import SpriteKit

public class BoxNode: SKSpriteNode{
    public init(){
        let texture = SKTexture(imageNamed: "box")
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        name="desk"
        self.zPosition = 5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
