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
    var isOfficeTerminalActive = true
    
    var player = Player.shared
    
    public init(){
        super.init(texture: nil, color: ColorPalette.backgroundGray, size: CGSize(width: 332 , height: 364))
        name="terminal"
        zPosition = 1
        setupForCliker()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupForCliker(){
        removeAllChildren()
        
        isOfficeTerminalActive = true
        
        pointsLabel.fontColor = ColorPalette.mainGreen
        pointsLabel.fontName = "Pixel"
        pointsLabel.zPosition = 1
        pointsLabel.fontSize = 25
        pointsLabel.text = "POINTS: \(player.points)"
        pointsLabel.horizontalAlignmentMode = .left
        pointsLabel.position = CGPoint(x:10, y: self.size.height-30)
        self.addChild(pointsLabel)
        
        codeLabel.fontColor = ColorPalette.mainGreen
        codeLabel.fontName = "Pixel"
        codeLabel.zPosition = 1
        codeLabel.fontSize = 15
        codeLabel.text = "CLICK TO CODE"
        codeLabel.horizontalAlignmentMode = .left
        codeLabel.position = CGPoint(x:10, y: self.size.height-50)
        self.addChild(codeLabel)
        
        codeLinesNode.anchorPoint = CGPoint(x: 0, y: 0)
        codeLinesNode.zPosition = 1
        codeLinesNode.scale(to: CGSize(width: 309 , height: 211))
        codeLinesNode.position = CGPoint(x:10, y: 52)
        self.addChild(codeLinesNode)
    }
    
    func setupForResults(text:String, name:String){
        removeAllChildren()
        
        isOfficeTerminalActive = false
        
        let app = App(points: player.points)
        
        pointsLabel.fontColor = ColorPalette.mainGreen
        pointsLabel.zPosition = 1
        pointsLabel.fontName = "Pixel"
        pointsLabel.fontSize = 25
        pointsLabel.text = "POINTS: \(app.points)"
        pointsLabel.horizontalAlignmentMode = .center
        pointsLabel.position = CGPoint(x:self.size.width/2, y: self.size.height-60)
        self.addChild(pointsLabel)
        
        let overAllLabel = SKLabelNode()
        overAllLabel.fontColor = ColorPalette.mainGreen
        overAllLabel.zPosition = 1
        overAllLabel.fontName = "Pixel"
        overAllLabel.numberOfLines = 0
        overAllLabel.fontSize = 22
        if name == "sellLabel" {
            overAllLabel.text = "Earning : \(app.earning)\nYou power was: \(player.clickPower())\nYour server is full\nto store more apps\nsell some apps\nstore in your server"
            overAllLabel.position = CGPoint(x:10, y: self.size.height-250)
        }
        else{
            overAllLabel.text = "Earning : \(app.earning)\nYou power was: \(player.clickPower())"
            overAllLabel.position = CGPoint(x:10, y: self.size.height/2)
        }
        overAllLabel.horizontalAlignmentMode = .left
        self.addChild(overAllLabel)
        
        let backgroundStoreLabel = SKSpriteNode(color: ColorPalette.mainGreen, size: CGSize(width: 300, height: 50))
        backgroundStoreLabel.zPosition = 2
        backgroundStoreLabel.name = name
        backgroundStoreLabel.position = CGPoint(x:self.size.width/2, y: 60)
        self.addChild(backgroundStoreLabel)
        
        let storeLabel = SKLabelNode()
        storeLabel.name = name
        storeLabel.zPosition = 2
        storeLabel.fontColor = .black
        storeLabel.fontName = "Pixel"
        storeLabel.fontSize = 25
        storeLabel.text = text
        storeLabel.horizontalAlignmentMode = .center
        storeLabel.position = CGPoint(x:self.size.width/2, y: 50)
        self.addChild(storeLabel)
        
        if name != "sellLabel" {
            let backgroundSellLabel = SKSpriteNode(color: ColorPalette.mainGreen, size: CGSize(width: 300, height: 50))
            backgroundSellLabel.zPosition = 2
            backgroundSellLabel.name = "sellLabel"
            backgroundSellLabel.position = CGPoint(x:self.size.width/2, y: 120)
            self.addChild(backgroundSellLabel)
            
            let sellLabel = SKLabelNode()
            sellLabel.name = "sellLabel"
            sellLabel.zPosition = 2
            sellLabel.fontColor = .black
            sellLabel.fontName = "Pixel"
            sellLabel.fontSize = 25
            sellLabel.text = "SELL: \(app.money)"
            sellLabel.horizontalAlignmentMode = .center
            sellLabel.position = CGPoint(x:self.size.width/2, y: 110)
            self.addChild(sellLabel)
        }
        

    }
        
    func addCodeLine(codeLine:CodeNode){
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
        if  player.points%15==0{
            codeLabel.text = PhrasesCode.allCases.randomElement()?.rawValue
        }
    }
}
