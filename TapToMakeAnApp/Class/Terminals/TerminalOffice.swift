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
    var codeLines = 0
    
    var points = 0
    
    let phrasesCode = ["DECLARING VARIABELS","CREATING FUNCTIONS","MAKING THE LOOP","TESTING THE APP"]
    
    public init(){
        super.init(texture: nil, color: UIColor.clear, size: CGSize(width: 332 , height: 364))
        name="terminal"
        setTerminalClicker()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTerminalClicker(){
        removeAllChildren()
        
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
        codeLabel.text = "CLICK TO CODE"
        codeLabel.horizontalAlignmentMode = .left
        codeLabel.position = CGPoint(x:10, y: self.size.height-50)
        self.addChild(codeLabel)
        
        codeLinesNode.anchorPoint = CGPoint(x: 0, y: 0)
        codeLinesNode.scale(to: CGSize(width: 309 , height: 211))
        codeLinesNode.position = CGPoint(x:10, y: 52)
        self.addChild(codeLinesNode)
    }
    
    func setTerminalResult() {
        removeAllChildren()
        
        pointsLabel.fontColor = ColorPalette.mainGreen
        pointsLabel.fontName = "Pixel"
        pointsLabel.fontSize = 25
        pointsLabel.text = "POINTS: \(points)"
        pointsLabel.horizontalAlignmentMode = .center
        pointsLabel.position = CGPoint(x:self.size.width/2, y: self.size.height-60)
        self.addChild(pointsLabel)
        
        let overAllLabel = SKLabelNode()
        overAllLabel.fontColor = ColorPalette.mainGreen
        overAllLabel.fontName = "Pixel"
        overAllLabel.numberOfLines = 0
        overAllLabel.fontSize = 20
        overAllLabel.text = "You clicked :\(points)\nYou use 3 programers\n with you had made\n1000points\nyour multiplaier would \nbe 2 times bigger"
        overAllLabel.horizontalAlignmentMode = .left
        overAllLabel.position = CGPoint(x:10, y: self.size.height-250)
        self.addChild(overAllLabel)
        
        let backgroundSellLabel = SKSpriteNode(color: ColorPalette.mainGreen, size: CGSize(width: 300, height: 50))
        backgroundSellLabel.name = "sellLabel"
        backgroundSellLabel.position = CGPoint(x:self.size.width/2, y: 60)
        self.addChild(backgroundSellLabel)
        
        let sellLabel = SKLabelNode()
        sellLabel.name = "sellLabel"
        sellLabel.fontColor = .black
        sellLabel.fontName = "Pixel"
        sellLabel.fontSize = 25
        sellLabel.text = "SELL :\(points*5)\n"
        sellLabel.horizontalAlignmentMode = .center
        sellLabel.position = CGPoint(x:self.size.width/2, y: 50)
        self.addChild(sellLabel)
    }
        
    func addCodeLine(codeLine:Code){
        if 211-15*codeLines>0{
            codeLine.anchorPoint = CGPoint(x: 0, y: 0)
            codeLine.position = CGPoint(x: 0, y: 211 - 15*codeLines)
            codeLinesNode.addChild(codeLine)
        }
        else{
            codeLines = -1
            codeLinesNode.removeAllChildren()
        }
        
    }
    
    func changeTextOfCodeLabel(){
        if points%15==0{
            codeLabel.text = phrasesCode[Int.random(in: 0..<phrasesCode.count)]
        }
    }
}
