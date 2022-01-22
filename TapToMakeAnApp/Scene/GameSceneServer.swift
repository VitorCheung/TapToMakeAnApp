//
//  GameSceneServer.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 13/01/22.
//

import SpriteKit
import GameplayKit

class GameSceneServe: SKScene {
    
    //data
    var player = Player.shared
    
    var isToucheMoved = false
    //Nodes
    let moneyLabel = SKLabelNode()
    let deadLineLabel = SKLabelNode()
    var terminalNode = TerminalServer()
    
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
                case "shop":
                    player.setPlayerUserDefaults()
                    self.view?.presentScene( GameSceneShop() )
                case "App":
                    let app = touchedNode as? SellAppNode
                    let yPositon = terminalNode.position.y
                    sellApp(positionApp: app?.positionLibrary,CGpositon: positionInScene )
                    for _ in 0..<10 {
                        rainMoney(CGpositon: positionInScene)
                    }
                    terminalNode.position.y = yPositon
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
            let countApp = CGFloat(player.apps.count)
            if terminalNode.position.y + deltaY > 100 && terminalNode.position.y + deltaY < 152*countApp {
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
        
        let boarderPainel = SKSpriteNode(color: .clear, size: CGSize(width: 350, height: 120))
        boarderPainel.zPosition = 5
        boarderPainel.drawBorder(color: .black, width: 8)
        boarderPainel.position = CGPoint(x:self.size.width/2, y: self.size.height-130)
        boarderPainel.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.addChild(boarderPainel)
        
        let painelLabel = SKLabelNode()
        painelLabel.fontColor = .red
        painelLabel.zPosition = 1
        painelLabel.fontName = "Pixel"
        painelLabel.fontSize = 25
        painelLabel.numberOfLines = 0
        painelLabel.text = "Apps: \(player.apps.count)/\(1+player.upgrades[4].level)\nEarning: \(player.totalEarning())$/Day"
        painelLabel.horizontalAlignmentMode = .center
        painelLabel.position = CGPoint(x:0, y: -30)
        boarderPainel.addChild(painelLabel)
        
        let serverNode = ServerNode()
        serverNode.zPosition = 6
        serverNode.position = CGPoint(x: self.size.width-50, y: 610)
        self.addChild(serverNode)
        
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
    
    func sellApp(positionApp: Int?,CGpositon: CGPoint){
        guard let position = positionApp else { return }
        player.money += player.apps[position]?.money ?? 0
        player.apps.remove(at: position)
        setup()
    }
    

}


