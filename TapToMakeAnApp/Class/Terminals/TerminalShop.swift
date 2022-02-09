//
//  TerminalShop.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 20/01/22.
//

import SpriteKit

public class TerminalShop: SKSpriteNode{
    
    var player = Player.shared
    var totalLines = 1
    
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
        totalLines = 1
        addUpgrade(x: self.size.width/2, y: self.size.height-CGFloat(197*0)-80, indexUpgrade: 0)
        
        
        for line in 1..<player.upgrades.count{
            if player.upgrades[line-1].level > 4{
                addUpgrade(x: self.size.width/2, y: self.size.height-CGFloat(197*line)-80, indexUpgrade: line)
                totalLines += 1
            }
        }
        
        if totalLines == player.upgrades.count {
            return
        }
        
        let borderInfo = SKSpriteNode(color: .clear, size: CGSize(width: 290, height: 180))
        borderInfo.zPosition = 1
        borderInfo.drawBorder(color: ColorPalette.mainGreen, width: 5)
        borderInfo.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        borderInfo.position = CGPoint(x: self.size.width/2, y: self.size.height-CGFloat(197*totalLines)-80)
        
        let labelInfo = SKLabelNode()
        labelInfo.fontColor = ColorPalette.mainGreen
        labelInfo.zPosition = 0
        labelInfo.fontName = "munro"
        labelInfo.numberOfLines = 0
        labelInfo.fontSize = 27
        let textInfo = NSLocalizedString("SKSpriteNode.TerminalShop.Label.LabelInfoUpgrades", comment: "information of how many upgrades is needed to unlock more upgrades")
        labelInfo.text = String.localizedStringWithFormat(textInfo,String(5-player.upgrades[totalLines-1].level))
        labelInfo.horizontalAlignmentMode = .center
        labelInfo.position = CGPoint(x:0, y: -labelInfo.fontSize)
        borderInfo.addChild(labelInfo)
        addChild(borderInfo)
        
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
        labelUpgrade.fontName = "munro"
        labelUpgrade.fontSize = 23
        labelUpgrade.text = NSLocalizedString("buy", comment: "")+": \(Int64.numRedable(num: upgrade.price))$"
        labelUpgrade.horizontalAlignmentMode = .center
        labelUpgrade.position = CGPoint(x:0, y: -63)
        borderUpgrade.addChild(labelUpgrade)
        
        let labelInfo = SKLabelNode()
        labelInfo.fontColor = ColorPalette.mainGreen
        labelInfo.zPosition = 0
        labelInfo.fontName = "munro"
        labelInfo.fontSize = 23
        labelInfo.numberOfLines = 0
        labelInfo.text = NSLocalizedString("\(upgrade.name).description", comment: "")
        labelInfo.horizontalAlignmentMode = .center
        labelInfo.position = CGPoint(x:0, y: -20)
        borderUpgrade.addChild(labelInfo)
        
        let labelTitle = SKLabelNode()
        labelTitle.fontColor = ColorPalette.mainGreen
        labelTitle.zPosition = 0
        labelTitle.fontName = "munro"
        labelTitle.fontSize = 30
        labelTitle.numberOfLines = 0
        labelTitle.text = NSLocalizedString("\(upgrade.name)", comment: "")
        labelTitle.horizontalAlignmentMode = .left
        labelTitle.position = CGPoint(x:-borderUpgrade.size.width/2+10, y: borderUpgrade.size.height/2-45)
        borderUpgrade.addChild(labelTitle)
        
        self.addChild(borderUpgrade)
        
        
    }
    
}
