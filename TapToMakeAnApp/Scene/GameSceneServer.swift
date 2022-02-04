//
//  GameSceneServer.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 13/01/22.
//

import SpriteKit
import GameplayKit

class GameSceneServe: SKScene {
    
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
                case "rank":
                    vc.showGameLeaderBoard()
                case "office":
                    if player.didTutorial[5]{
                    player.setPlayerUserDefaults()
                    self.view?.presentScene( GameSceneOffice(vc: vc)  )
                    }
                case "team":
                    if player.didTutorial[5]{
                    player.setPlayerUserDefaults()
                    self.view?.presentScene( GameSceneTeam(vc: vc)  )
                    }
                case "docs":
                    if player.didTutorial[4]{
                    player.setPlayerUserDefaults()
                    self.view?.presentScene( GameSceneDocs(vc: vc)  )
                    }
                case "shop":
                    if player.didTutorial[5]{
                    player.setPlayerUserDefaults()
                    self.view?.presentScene( GameSceneShop(vc: vc)  )
                    }
                case "App":
                    if player.didTutorial[3]{
                    
                    let app = touchedNode as? SellAppNode
                    let yPositon = terminalNode.position.y
                    sellApp(positionApp: app?.positionLibrary,CGpositon: positionInScene )
                    for _ in 0..<10 {
                        rainMoney(CGpositon: positionInScene)
                    }
                    terminalNode.position.y = yPositon
                        if !player.didTutorial[4]{
                            let tutorial = tutorialNode(text: "Nice!!\nUse this money to\ncontract a worker!\nGo to Docs tab")
                            addChild(tutorial)
                        }
                    player.setPlayerUserDefaults()
                    ManagerGameCenter.setHighScore(score: Player.shared.money)
                    }
                case "tutorial":

                    if !player.didTutorial[3]{
                        player.didTutorial[3].toggle()
                        setup()
                        break
                    }
                    if !player.didTutorial[4]{
                        player.didTutorial[4].toggle()
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
        moneyLabel.text = "$\(Int64.numRedable(num: player.money))"
        
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

        if !player.didTutorial[3]{
            let tutorial = tutorialNode(text: "Here you can see how\nmuch money yours apps\nare making and how\nmany apps you can\nstore!\nYou can sell apps here\ntoo! Try to sell one")
            addChild(tutorial)
        }
        //MARK: Labels
        
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
        
        let boarderPainel = SKSpriteNode(color: .clear, size: CGSize(width: 350, height: 120))
        boarderPainel.zPosition = 5
        boarderPainel.drawBorder(color: .black, width: 8)
        boarderPainel.position = CGPoint(x:self.size.width/2, y: self.size.height-130)
        boarderPainel.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.addChild(boarderPainel)
        
        let painelLabel = SKLabelNode()
        painelLabel.fontColor = .red
        painelLabel.zPosition = 1
        painelLabel.fontName = "munro"
        painelLabel.fontSize = 30
        painelLabel.numberOfLines = 0
        painelLabel.text = "Apps: \(player.apps.count)/\(player.serverSpace)\nEarning: \(Int64.numRedable(num: player.totalEarning()))$/Day"
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


