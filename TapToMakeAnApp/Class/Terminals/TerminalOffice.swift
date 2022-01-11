//
//  Terminal.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 10/01/22.
//
import SpriteKit

public class TerminalOffice: SKSpriteNode{
    
    let pointsLabel = SKLabelNode()
    let codeLabel = SKLabelNode()
    let codeLinesNode = SKSpriteNode()
    var points = 0
    var codeLen = 211
    
    let phrasesCode = ["DECLARING VARIABELS","CREATING FUNCTIONS","MAKING THE LOOP","TESTING THE APP"]
    
    public init(){
        super.init(texture: nil, color: UIColor.clear, size: CGSize(width: 332 , height: 364))
        name="terminal"
        
        pointsLabel.fontColor = ColorPalette.mainGreen
        pointsLabel.fontName = "Pixel"
        pointsLabel.fontSize = 25
        pointsLabel.text = "POINTS: \(points)"
        pointsLabel.horizontalAlignmentMode = .left
        pointsLabel.position = CGPoint(x:10, y: self.size.height-30)
        self.addChild(pointsLabel)
        
        codeLabel.fontColor = ColorPalette.mainGreen
        codeLabel.fontName = "Pixel"
        codeLabel.fontSize = 15
        codeLabel.text = "CLICK TO START CODING"
        codeLabel.horizontalAlignmentMode = .left
        codeLabel.position = CGPoint(x:10, y: self.size.height-50)
        self.addChild(codeLabel)
        
        codeLinesNode.anchorPoint = CGPoint(x: 0, y: 0)
        codeLinesNode.scale(to: CGSize(width: 309 , height: 211))
        codeLinesNode.position = CGPoint(x:10, y: 52)
        self.addChild(codeLinesNode)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addCodeLine(codeLine:Code){
        if codeLen-15*points>0{
            codeLine.anchorPoint = CGPoint(x: 0, y: 0)
            codeLine.position = CGPoint(x: 0, y: codeLen - 15*points)
            codeLinesNode.addChild(codeLine)
        }
        else{
            codeLinesNode.removeAllChildren()
            codeLen += 211
        }
        
    }
    
    func changeTextOfCodeLabel(){
        if points%15==0{
            codeLabel.text = phrasesCode[Int.random(in: 0..<phrasesCode.count)]
        }
    }
}
