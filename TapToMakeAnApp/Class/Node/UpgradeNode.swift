//
//  UpgradeNode.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 20/01/22.
//

import SpriteKit

public class UpgradeNode: SKSpriteNode{
    
    var positionLibrary : Int
    public init(positionLibrary: Int){
        
        self.positionLibrary = positionLibrary
        super.init(texture: nil, color: .clear, size: CGSize(width: 200, height: 42))
        name="upgrade"
        self.zPosition = 4
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    
}
