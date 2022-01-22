//
//  TerminalShop.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 20/01/22.
//

import SpriteKit

public class TerminalShop: SKSpriteNode{
    
    var player = Player.shared
    
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
        removeAllChildren()
        
        for line in 0..<player.upgrades.count{
            addUpgrade(x: self.size.width/2, y: self.size.height-CGFloat(197*line)-80, indexUpgrade: line)
            
        }
    }
    
    func addUpgrade(x:CGFloat, y:CGFloat, indexUpgrade: Int){
        
        let upgrade = player.upgrades[indexUpgrade]
        
        let borderUpgrade = SKSpriteNode(color: .clear, size: CGSize(width: 290, height: 180))
        borderUpgrade.zPosition = 1
        borderUpgrade.drawBorder(color: ColorPalette.mainGreen, width: 5)
        borderUpgrade.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        borderUpgrade.position = CGPoint(x: x, y: y)
        
        let upgradeButton = UpgradeNode(positionLibrary: indexUpgrade)
        upgradeButton.size = CGSize(width: 250, height: 42)
        upgradeButton.zPosition = 1
        upgradeButton.position = CGPoint(x:0, y: -58)
        borderUpgrade.addChild(upgradeButton)
        
        let upgradeBackground = SKSpriteNode(color: ColorPalette.mainGreen, size: CGSize(width: 250, height: 42))
        upgradeBackground.zPosition = 0
        upgradeBackground.position = CGPoint(x:0, y: -58)
        borderUpgrade.addChild(upgradeBackground)

        let labelUpgrade = SKLabelNode()
        labelUpgrade.fontColor = .black
        labelUpgrade.zPosition = 0
        labelUpgrade.fontName = "Pixel"
        labelUpgrade.fontSize = 18
        labelUpgrade.text = "BUY: \(upgrade.price)$"
        labelUpgrade.horizontalAlignmentMode = .center
        labelUpgrade.position = CGPoint(x:0, y: -63)
        borderUpgrade.addChild(labelUpgrade)
        
        let labelInfo = SKLabelNode()
        labelInfo.fontColor = ColorPalette.mainGreen
        labelInfo.zPosition = 0
        labelInfo.fontName = "Pixel"
        labelInfo.fontSize = 20
        labelInfo.numberOfLines = 0
        labelInfo.text = upgrade.description
        labelInfo.horizontalAlignmentMode = .center
        labelInfo.position = CGPoint(x:0, y: -15)
        borderUpgrade.addChild(labelInfo)
        
        let labelTitle = SKLabelNode()
        labelTitle.fontColor = ColorPalette.mainGreen
        labelTitle.zPosition = 0
        labelTitle.fontName = "Pixel"
        labelTitle.fontSize = 25
        labelTitle.numberOfLines = 0
        labelTitle.text = upgrade.name+":"
        labelTitle.horizontalAlignmentMode = .left
        labelTitle.position = CGPoint(x:-borderUpgrade.size.width/2+10, y: borderUpgrade.size.height/2-45)
        borderUpgrade.addChild(labelTitle)
        
        self.addChild(borderUpgrade)
        
        
    }
    
}
