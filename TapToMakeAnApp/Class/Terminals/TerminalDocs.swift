//
//  TerminalDocs.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 13/01/22.
//

import SpriteKit

public class TerminalDocs: SKSpriteNode{
    
    let player = Player.getPlayerUserDefaults()
    
    public init(){
        super.init(texture: nil, color: ColorPalette.backgroundGray, size: CGSize(width: 332 , height: 364))
        name="terminal"
        self.zPosition = -1
        self.anchorPoint = CGPoint(x: 0, y: 0)
        setup()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setup(){
        
        let hireLabel = SKLabelNode()
        hireLabel.fontColor = ColorPalette.mainGreen
        hireLabel.fontName = "Pixel"
        hireLabel.zPosition = 1
        hireLabel.fontSize = 30
        hireLabel.text = "HIRE"
        hireLabel.horizontalAlignmentMode = .left
        hireLabel.position = CGPoint(x:15, y: self.size.height-30)
        self.addChild(hireLabel)
        
        let boardNode = SKSpriteNode(color: .clear, size: CGSize(width: 280, height: 85))
        boardNode.drawBorder(color: ColorPalette.mainGreen, width: 5)
        boardNode.zPosition = 1
        boardNode.position = CGPoint(x:self.size.width/2, y: self.size.height/2+30)
        self.addChild(boardNode)
        
        let backgroundcontratLabelNode = SKSpriteNode(color: .clear, size: CGSize(width: 280, height: 85))
        backgroundcontratLabelNode.zPosition = 1
        backgroundcontratLabelNode.position = CGPoint(x:self.size.width/2, y: self.size.height/2+30)
        backgroundcontratLabelNode.name = "contrat"
        self.addChild(backgroundcontratLabelNode)
        
        let contratLabel = SKLabelNode()
        contratLabel.fontColor = ColorPalette.mainGreen
        contratLabel.name = "contrat"
        contratLabel.fontName = "Pixel"
        contratLabel.zPosition = 1
        contratLabel.numberOfLines = 0
        contratLabel.fontSize = 20
        contratLabel.text = "1 contrat X\n$100.000"
        contratLabel.horizontalAlignmentMode = .center
        contratLabel.position = CGPoint(x:self.size.width/2, y: self.size.height/2)
        self.addChild(contratLabel)
        
    }
    
}

