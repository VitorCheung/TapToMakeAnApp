//
//  rankButtonNode.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 25/01/22.
//

import Foundation
import SpriteKit

public class RankButtonNode: SKSpriteNode{
    public init(){
        let texture = SKTexture(imageNamed: "rank")
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        name="rank"
        self.zPosition = 10
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
