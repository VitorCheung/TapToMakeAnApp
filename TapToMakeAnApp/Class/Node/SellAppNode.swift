//
//  AppNode.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 14/01/22.
//

import SpriteKit

public class SellAppNode: SKSpriteNode{
    public var app : App?
    public var positionLibrary : Int?
    public init(app:App,positionLibrary: Int){
        
        self.app = app
        self.positionLibrary = positionLibrary
        super.init(texture: nil, color: .clear, size: CGSize(width: 200, height: 42))
        name="App"
        self.zPosition = 4
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    
}

