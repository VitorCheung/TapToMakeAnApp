//
//  Buttom.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 10/01/22.
//

import SpriteKit

public class ButtonTabBar: SKSpriteNode{
    
    public init(img: String, name: String){
        super.init(texture: nil, color: .clear, size: CGSize(width: 54, height: 54))
        
        self.anchorPoint =  CGPoint(x: 0.5, y:0.5)
        self.name = name
        self.zPosition = 2
        
        let iconNode = SKSpriteNode(imageNamed: img)
        iconNode.anchorPoint =  CGPoint(x: 0.5, y:0)
        iconNode.position = CGPoint(x:self.size.width/2, y: self.size.height-32)
        iconNode.name = name
        self.addChild(iconNode)
        
        
        let label = SKLabelNode()
        label.fontColor = ColorPalette.mainGreen
        label.fontName = "Pixel"
        label.fontSize = 15
        label.text = name
        label.name = name
        label.horizontalAlignmentMode = .center
        label.position = CGPoint(x:self.size.width/2, y: self.size.height-46)
        self.addChild(label)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

