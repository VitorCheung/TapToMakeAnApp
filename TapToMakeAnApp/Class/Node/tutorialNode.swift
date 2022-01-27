//
//  tutorialNode.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 26/01/22.
//

import Foundation
import SpriteKit

class tutorialNode: SKSpriteNode{
    
    public init(text:String){
        super.init(texture: nil, color: UIColor.clear, size: CGSize(width: 428 , height: 840))
        self.anchorPoint = CGPoint(x: 0, y: 0)
        self.zPosition = 12
        
        let japa = WorkerNode(worker: Worker.library[18])
        japa.setScale(5)
        japa.zPosition = -1
        japa.position = CGPoint( x: 100, y: 0)
        self.addChild(japa)
        
        let info = SKSpriteNode(color: .white, size: CGSize(width: 310, height: 400))
        info.zPosition = -1
        info.drawBorder(color: .black, width: 8)
        info.position = CGPoint( x: 250, y: self.size.height/2+125)
        
        let labelInfo = SKLabelNode()
        labelInfo.fontColor = .black
        labelInfo.fontName = "munro"
        labelInfo.fontSize = 30
        labelInfo.numberOfLines = 0
        labelInfo.text = text
        labelInfo.horizontalAlignmentMode = .left
        guard let numbersOfWords = labelInfo.text?.count else { return }
        let numberOfLines: Double = Double(numbersOfWords)/19
        labelInfo.position = CGPoint(x: -info.size.width/2+10, y: -numberOfLines*15)
        info.addChild(labelInfo)
        
        let backgroundOK = SKSpriteNode(color: ColorPalette.mainGreen, size: CGSize(width: 230, height: 50))
        backgroundOK.drawBorder(color: .white, width: 8)
        backgroundOK.zPosition = 3
        backgroundOK.position = CGPoint(x:self.size.width/2+65, y: 230)
        
        let bgOKSupport = SKSpriteNode(color: .clear, size: CGSize(width: 230, height: 50))
        bgOKSupport.zPosition = 3
        bgOKSupport.name = "tutorial"
        bgOKSupport.position = CGPoint(x:0, y: 0)
        backgroundOK.addChild(bgOKSupport)
        
        let OKLabel = SKLabelNode()
        OKLabel.name = "tutorial"
        OKLabel.zPosition = 1
        OKLabel.fontColor = .black
        OKLabel.fontName = "munro"
        OKLabel.fontSize = 30
        OKLabel.text = "OK"
        OKLabel.horizontalAlignmentMode = .center
        OKLabel.position = CGPoint(x:0, y: -10)
        backgroundOK.addChild(OKLabel)
        
        self.addChild(backgroundOK)
        
        self.addChild(info)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
