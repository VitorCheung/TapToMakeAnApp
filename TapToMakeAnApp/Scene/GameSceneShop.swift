//
//  GameSceneShop.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 20/01/22.
//

import SpriteKit
import GameplayKit

class GameSceneShop: SKScene {
    
    var vc : GameViewController
    
    init( vc : GameViewController) {
        self.vc = vc
        super.init(size: CGSize(width: 428 , height: 840))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //data
    var player = Player.shared
    
    var isToucheMoved = false
    
    //Nodes
    let moneyLabel = SKLabelNode()
    let deadLineLabel = SKLabelNode()
    var terminalNode = TerminalShop()
    let boxNode = BoxNode()
    
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
                case "rank":
                    vc.showGameLeaderBoard()
                case "office":
                    if player.didTutorial[12]{
                    player.setPlayerUserDefaults()
                    self.view?.presentScene( GameSceneOffice(vc: vc)  )
                    }
                case "team":
                    if player.didTutorial[12]{
                    player.setPlayerUserDefaults()
                    self.view?.presentScene( GameSceneTeam(vc: vc)  )
                    }
                case "docs":
                    if player.didTutorial[12]{
                    player.setPlayerUserDefaults()
                    self.view?.presentScene( GameSceneDocs(vc: vc) )
                    }
                case "server":
                    if player.didTutorial[12]{
                    player.setPlayerUserDefaults()
                    self.view?.presentScene( GameSceneServe(vc: vc)  )
                    }
                case "upgrade":

                    guard let upgrade = touchedNode as? UpgradeNode else { return  }
                    let yPositon = terminalNode.position.y
                    buyUpgrade(index: upgrade.positionLibrary, CGPositon:positionInScene)
                    terminalNode.position.y = yPositon
                    if !player.didTutorial[12]{
                        let tutorial = tutorialNode(text: "Okaay!\nYou are all set!\nNow tou can\nTAP TO MAKE AN APP!")
                        addChild(tutorial)
                    }
                    player.setPlayerUserDefaults()
                case "tutorial":

                    if !player.didTutorial[11]{
                        player.didTutorial[11].toggle()
                        setup()
                        break
                    }
                    
                    if !player.didTutorial[12]{
                        player.didTutorial[12].toggle()
                        setup()
                        break
                    }

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
            if terminalNode.position.y + deltaY > 90  && terminalNode.position.y + deltaY < 197*CGFloat(terminalNode.totalLines)+1 {
                terminalNode.position.y += deltaY
            }
        }
        
    }
    
    func setup(){
        removeAllChildren()
        //MARK: Labels
        
        if !player.didTutorial[11]{
            let tutorial = tutorialNode(text: "This is the shop\nyou can buy upgrades\nhere!\ntry to buy one!")
            addChild(tutorial)
        }
        
        moneyLabel.fontColor = .black
        moneyLabel.zPosition = 10
        moneyLabel.fontName = "munro"
        moneyLabel.fontSize = 35
        moneyLabel.text = "$\(player.money)"
        moneyLabel.horizontalAlignmentMode = .left
        moneyLabel.position = CGPoint(x:10, y: self.size.height-30)
        self.addChild(moneyLabel)
        
        deadLineLabel.fontColor = .red
        deadLineLabel.zPosition = 10
        deadLineLabel.fontName = "munro"
        deadLineLabel.fontSize = 30
        deadLineLabel.text = "Dead line: 10 days"
        deadLineLabel.horizontalAlignmentMode = .left
        deadLineLabel.position = CGPoint(x:10, y: self.size.height-55)
        self.addChild(deadLineLabel)
        
        let rankButtonNode = RankButtonNode()
        rankButtonNode.size = CGSize(width: 40, height: 40)
        rankButtonNode.position = CGPoint(x: self.size.width-30, y: self.size.height-30)
        self.addChild(rankButtonNode)
        
        boxNode.zPosition = 6
        boxNode.position = CGPoint(x: self.size.width/2, y: 630)
        boxNode.physicsBody = SKPhysicsBody(rectangleOf: boxNode.size)
        self.addChild(boxNode)
        
        //MARK: Bg
        let backgroundNode = BackgroundNode()
        let backgroundNodePhysic = SKSpriteNode(color: .clear, size: CGSize(width: self.size.width, height: 5))
        let whiteBackgroundNode = SKSpriteNode(color: .white, size: CGSize(width: 428, height: 300))
        
        whiteBackgroundNode.zPosition = 4
        whiteBackgroundNode.anchorPoint = CGPoint(x: 0.5, y: 0)
        whiteBackgroundNode.position = CGPoint( x: self.size.width/2, y: 600)
        self.addChild(whiteBackgroundNode)
        
        backgroundNode.zPosition = 5
        backgroundNode.anchorPoint = CGPoint(x: 0.5, y: 0)
        backgroundNode.position = CGPoint( x: self.size.width/2, y: 500)
        self.addChild(backgroundNode)
        
        backgroundNodePhysic.physicsBody = SKPhysicsBody(rectangleOf: backgroundNodePhysic.size)
        backgroundNodePhysic.physicsBody?.affectedByGravity = false
        backgroundNodePhysic.physicsBody?.isDynamic = false
        backgroundNodePhysic.zPosition = 6
        backgroundNodePhysic.position = CGPoint(x: self.size.width/2, y: 500)
        self.addChild(backgroundNodePhysic)
        
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

    func buyUpgrade(index:Int, CGPositon:CGPoint){
        if player.money > player.upgrades[index].price{
            player.money -= player.upgrades[index].price
            player.upgrades[index].level += 1
            setup()
            animationBuy()
            for _ in 0..<10 {
                rainMoney(CGpositon: CGPositon)
            }
        }
    }
    
    func animationBuy(){
        
        let sequence = SKAction.sequence([
            SKAction.applyImpulse(CGVector(dx: -5000, dy: 0), duration: 0.2),
            SKAction.stop(),
            SKAction.wait(forDuration: 0.5),
            SKAction.run { [self] in
                boxNode.removeFromParent()
                boxNode.position = CGPoint(x: self.size.width/2, y: self.size.height+100)
                boxNode.zPosition = 6
                boxNode.physicsBody = SKPhysicsBody(rectangleOf: boxNode.size)
                self.addChild(boxNode)
            }
        ])
        
        boxNode.run(
            sequence
        )
    }
    
}


