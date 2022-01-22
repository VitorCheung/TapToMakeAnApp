//
//  GameSceneShop.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 20/01/22.
//

import SpriteKit
import GameplayKit

class GameSceneShop: SKScene {
    
    //data
    var player = Player.shared
    
    var isToucheMoved = false
    //Nodes
    let moneyLabel = SKLabelNode()
    let deadLineLabel = SKLabelNode()
    var terminalNode = TerminalShop()
    
    override func didMove(to view: SKView) {
        // Set the scale mode to scale to fit the window
        self.scaleMode = .aspectFit
        // Set scene to phone size
        self.size = CGSize(width: 428 , height: 840)
    
        self.backgroundColor = ColorPalette.backgroundGray
        
        //Difine de size of the scene
        self.anchorPoint = CGPoint(x: 0, y: 0)
        
        //Difine de size of the scene
        self.anchorPoint = CGPoint(x: 0, y: 0)

        setup()

    }
    
    //MARK: TouchesEnded
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !(isToucheMoved){
            for touch in touches {
                let positionInScene = touch.location(in: self)
                let touchedNode = self.atPoint(positionInScene)
                switch touchedNode.name{
                case "office":
                    player.setPlayerUserDefaults()
                    self.view?.presentScene( GameSceneOffice() )
                case "team":
                    player.setPlayerUserDefaults()
                    self.view?.presentScene( GameSceneTeam() )
                case "docs":
                    player.setPlayerUserDefaults()
                    self.view?.presentScene( GameSceneDocs() )
                case "server":
                    player.setPlayerUserDefaults()
                    self.view?.presentScene( GameSceneServe() )
                case "upgrade":
                    guard let upgrade = touchedNode as? UpgradeNode else { return  }
                    let yPositon = terminalNode.position.y
                    buyUpgrade(index: upgrade.positionLibrary)
                    terminalNode.position.y = yPositon
                    for _ in 0..<10 {
                        rainMoney(CGpositon: positionInScene)
                    }
                    player.setPlayerUserDefaults()
                default:
                    return
                }
            }
        }
        else{
            isToucheMoved = false
        }
        
    }
    
    //MARK: Update
    override func update(_ currentTime: TimeInterval) {
        deadLineLabel.text = "Dead line: \(timerDeadLine.shared.deadLine) days"
        moneyLabel.text = "$\(player.money)"
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        isToucheMoved = true
        for touch in touches {
            let location = touch.location(in: self)
            let previousLocation = touch.previousLocation(in: self)
            let deltaY = location.y - previousLocation.y
            let countUpgrades = CGFloat(player.upgrades.count)
            if terminalNode.position.y + deltaY > 90  && terminalNode.position.y + deltaY < 197*countUpgrades {
                terminalNode.position.y += deltaY
            }
        }
        
    }
    
    func setup(){
        removeAllChildren()


        //MARK: Labels
        
        moneyLabel.fontColor = .black
        moneyLabel.zPosition = 10
        moneyLabel.fontName = "Pixel"
        moneyLabel.fontSize = 25
        moneyLabel.text = "$\(player.money)"
        moneyLabel.horizontalAlignmentMode = .left
        moneyLabel.position = CGPoint(x:10, y: self.size.height-25)
        self.addChild(moneyLabel)
        
        deadLineLabel.fontColor = .red
        deadLineLabel.zPosition = 10
        deadLineLabel.fontName = "Pixel"
        deadLineLabel.fontSize = 25
        deadLineLabel.text = "Dead line: 10 days"
        deadLineLabel.horizontalAlignmentMode = .left
        deadLineLabel.position = CGPoint(x:10, y: self.size.height-55)
        self.addChild(deadLineLabel)
        
        let boxNode = BoxNode()
        boxNode.zPosition = 6
        boxNode.position = CGPoint(x: self.size.width/2, y: 630)
        self.addChild(boxNode)
        
        //MARK: Bg
        let backgroundNode = BackgroundNode()
        let whiteBackgroundNode = SKSpriteNode(color: .white, size: CGSize(width: 428, height: 300))
        
        whiteBackgroundNode.zPosition = 4
        whiteBackgroundNode.anchorPoint = CGPoint(x: 0.5, y: 0)
        whiteBackgroundNode.position = CGPoint( x: self.size.width/2, y: 600)
        self.addChild(whiteBackgroundNode)
        
        backgroundNode.zPosition = 5
        backgroundNode.anchorPoint = CGPoint(x: 0.5, y: 0)
        backgroundNode.position = CGPoint( x: self.size.width/2, y: 500)
        self.addChild(backgroundNode)
        
        //MARK: Screem
        
        let screemNode = ScreemNode()
        screemNode.anchorPoint = CGPoint(x: 0, y: 0)
        screemNode.position = CGPoint( x: 0 , y: 0)
        screemNode.name = "screem"
        self.addChild(screemNode)
        
        terminalNode.setup()
        terminalNode.zPosition = 1
        terminalNode.anchorPoint = CGPoint(x: 0, y: 0)
        terminalNode.position = CGPoint(x: 48, y: 117)
        addChild(terminalNode)
        
        
    }

    func buyUpgrade(index:Int){
        player.money -= player.upgrades[index].price
        player.upgrades[index].level += 1
        setup()
    }
}


