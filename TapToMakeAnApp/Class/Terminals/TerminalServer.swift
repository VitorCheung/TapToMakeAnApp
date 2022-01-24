//
//  TerminalServer.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 13/01/22.
//

import SpriteKit

public class TerminalServer: SKSpriteNode{
    
    var player = Player.shared
    
    public init(){
        super.init(texture: nil, color: ColorPalette.backgroundGray, size: CGSize(width: 332 , height: 364))
        name="terminal"
        self.zPosition = -1
        self.anchorPoint = CGPoint(x: 0, y: 0)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setup(){
        removeAllChildren()
        
        for line in 0..<player.apps.count{
            addApp(x: self.size.width/2, y: self.size.height-CGFloat(162*line)-80, indexApp: line)
            
        }
    }
    
    func addApp(x:CGFloat, y:CGFloat, indexApp: Int){
        guard let app = player.apps[indexApp] else { return }
        
        let borderApp = SKSpriteNode(color: .clear, size: CGSize(width: 290, height: 152))
        borderApp.zPosition = 1
        borderApp.drawBorder(color: ColorPalette.mainGreen, width: 5)
        borderApp.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        borderApp.position = CGPoint(x: x, y: y)
        
        let sellButton = SellAppNode(app: app, positionLibrary: indexApp)
        sellButton.zPosition = 1
        sellButton.position = CGPoint(x:0, y: -30)
        borderApp.addChild(sellButton)
        
        let sellBackground = SKSpriteNode(color: ColorPalette.mainGreen, size: CGSize(width: 200, height: 42))
        sellBackground.zPosition = 0
        sellBackground.position = CGPoint(x:0, y: -30)
        borderApp.addChild(sellBackground)

        let labelApp = SKLabelNode()
        labelApp.fontColor = .black
        labelApp.zPosition = 0
        labelApp.fontName = "Pixel"
        labelApp.fontSize = 18
        labelApp.text = "SELL: \(app.money)$"
        labelApp.horizontalAlignmentMode = .center
        labelApp.position = CGPoint(x:0, y: -35)
        borderApp.addChild(labelApp)
        
        let labelInfo = SKLabelNode()
        labelInfo.fontColor = ColorPalette.mainGreen
        labelInfo.zPosition = 0
        labelInfo.fontName = "Pixel"
        labelInfo.fontSize = 20
        labelInfo.numberOfLines = 0
        labelInfo.text = "POINTS: \(app.points)\nEANING: \(app.earning)$"
        labelInfo.horizontalAlignmentMode = .center
        labelInfo.position = CGPoint(x:0, y: 5)
        borderApp.addChild(labelInfo)
        
        self.addChild(borderApp)
        
        
    }
    
}

