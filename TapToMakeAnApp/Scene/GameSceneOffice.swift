//
//  GameScene.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 07/01/22.
//

import SpriteKit
import GameplayKit

class GameSceneOffice: SKScene {
    
    //data
    var player = Player.shared
    
    //Timer
    var timer = timerDeadLine.shared

    //Nodes
    let moneyLabel = SKLabelNode()
    let deadLineLabel = SKLabelNode()
    var terminalNode = TerminalOffice()
    
    override func didMove(to view: SKView) {
        // Set the scale mode to scale to fit the window
        self.scaleMode = .aspectFit

        // Set scene to phone size
        self.size = CGSize(width: 428 , height: 840)
        
        self.backgroundColor = .white
        
        //Difine de size of the scene
        self.anchorPoint = CGPoint(x: 0, y: 0)
        
        setup()

    }
    
    //MARK: TouchesEnded
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        switch touchedNode.name{
            case "storeLabel":
                timer.deadLine = player.deadLine
                timer.isDeadLineEnded = false
                terminalNode.setupForCliker()
                player.apps.append(App(points: player.points))
                player.points = 0
                addToServerAnamation()
                player.setPlayerUserDefaults()
            case "sellLabel":
            
                let app = App(points: player.points)
            for _ in 0..<10+player.upgrades[4].level {
                    rainMoney(CGpositon: positionInScene)
                }
                timer.deadLine = player.deadLine
                timer.isDeadLineEnded = false
                terminalNode.setupForCliker()
                player.money += Int64(app.money)
                player.points = 0
                player.setPlayerUserDefaults()
            case "team":
                player.setPlayerUserDefaults()
                self.view?.presentScene( GameSceneTeam() )
            case "docs":
                player.setPlayerUserDefaults()
                self.view?.presentScene( GameSceneDocs() )
            case "server":
                player.setPlayerUserDefaults()
                self.view?.presentScene( GameSceneServe() )
        case "shop":
            player.setPlayerUserDefaults()
            self.view?.presentScene( GameSceneShop() )
            default:
            
                if terminalNode.isOfficeTerminalActive {
                    addLabelPointsAnamation(x:positionInScene.x, y:positionInScene.y)

                }
            
                if timer.firstCliked{
                    timer.firstCliked = false
                }
                
                if !(timer.isDeadLineEnded){
                    player.points += player.clickPower()
                    terminalNode.addCodeLine(codeLine: CodeNode(width: Int.random(in: 80..<300)))
                    terminalNode.changeTextOfCodeLabel()
                    terminalNode.codeLines += 1
                }
            }
        }
        
    }
    
    //MARK: Update
    override func update(_ currentTime: TimeInterval) {
        
        terminalNode.pointsLabel.text = "POINTS: \(player.points)"
        deadLineLabel.text = "Dead line: \(timer.deadLine) days"
        moneyLabel.text = "$\(player.money)"
//        if points%5==0 {
//            //jump worker
//        }
        
        if timer.isDeadLineEnded{
            player.setPlayerUserDefaults()
            if player.apps.count < 1+player.upgrades[4].level && player.points != 0{
                terminalNode.setupForResults(text: "STORE APP", name: "storeLabel")
            }
            else{
                let app = App(points: player.points)
                terminalNode.setupForResults(text: "SELL: \(app.money)", name: "sellLabel")
            }
            return
        }
        

        
    }
    
    func setup(){
        //MARK: Labels
        
        timer.starCounter()
        
        moneyLabel.fontColor = .black
        moneyLabel.fontName = "Pixel"
        moneyLabel.fontSize = 25
        moneyLabel.text = "$\(player.money)"
        moneyLabel.horizontalAlignmentMode = .left
        moneyLabel.position = CGPoint(x:10, y: self.size.height-25)
        self.addChild(moneyLabel)
        
        deadLineLabel.fontColor = .red
        deadLineLabel.fontName = "Pixel"
        deadLineLabel.fontSize = 25
        deadLineLabel.text = "Dead line: 10 days"
        deadLineLabel.horizontalAlignmentMode = .left
        deadLineLabel.position = CGPoint(x:10, y: self.size.height-55)
        self.addChild(deadLineLabel)
        
        //MARK: WORKER
        let worker1 = WorkerNode(worker: player.team[0])
        let worker2 = WorkerNode(worker: player.team[1])
        let worker3 = WorkerNode(worker: player.team[2])
        
        worker1.position = CGPoint( x: self.size.width*3/20-20, y: 630)
        self.addChild(worker1)
        
        worker2.position = CGPoint( x: self.size.width/2-20, y: 630)
        self.addChild(worker2)
        
        worker3.position = CGPoint( x: self.size.width*17/20-20 , y: 630)
        self.addChild(worker3)
        
        //MARK: Desks
        let desk1 = DeskNode()
        let desk2 = DeskNode()
        let desk3 = DeskNode()
        
        desk1.anchorPoint = CGPoint(x: 0.5, y: 0)
        desk1.position = CGPoint( x: self.size.width*3/20+20, y: 550)
        self.addChild(desk1)
        
        desk2.anchorPoint = CGPoint(x: 0.5, y: 0)
        desk2.position = CGPoint( x: self.size.width/2+20, y: 550)
        self.addChild(desk2)
        
        desk3.anchorPoint = CGPoint(x: 0.5, y: 0)
        desk3.position = CGPoint( x: self.size.width*17/20+20 , y: 550)
        self.addChild(desk3)
        
        //MARK: Bg
        let backgroundNode = BackgroundNode()
        
        backgroundNode.anchorPoint = CGPoint(x: 0.5, y: 0)
        backgroundNode.position = CGPoint( x: self.size.width/2, y: 500)
        self.addChild(backgroundNode)
        
        //MARK: windows
        let window1 = WindowNode()
        let window2 = WindowNode()
        
        window1.anchorPoint = CGPoint(x: 0.75, y: 0)
        window1.position = CGPoint(x: self.size.width*1/3, y: 650)
        self.addChild(window1)
        
        window2.anchorPoint = CGPoint(x: 0.25, y: 0)
        window2.position = CGPoint(x: self.size.width*2/3, y: 650)
        self.addChild(window2)
        
        //MARK: Terminal
        terminalNode.setupForCliker()
        terminalNode.anchorPoint = CGPoint(x: 0, y: 0)
        terminalNode.position = CGPoint(x: 48, y: 117)
        addChild(terminalNode)
        
        //MARK: Screem
        let screemNode = ScreemNode()
        screemNode.anchorPoint = CGPoint(x: 0, y: 0)
        screemNode.position = CGPoint( x: 0 , y: 0)
        self.addChild(screemNode)

    }
    
    func addLabelPointsAnamation(x:CGFloat, y:CGFloat){
        let labelPoints = SKLabelNode()
        labelPoints.fontColor = ColorPalette.mainGreen
        labelPoints.zPosition = 11
        labelPoints.fontName = "Pixel"
        labelPoints.fontSize = 30
        labelPoints.text = "+\(player.clickPower())"
        labelPoints.horizontalAlignmentMode = .center
        labelPoints.position = CGPoint(x:x, y: y)
        self.addChild(labelPoints)
        labelPoints.run(
        SKAction.moveTo(y: self.size.height, duration: 1)
        , completion: labelPoints.removeFromParent)
    }
    
    func addToServerAnamation(){
        
        var compressFrames: [SKTexture] = []

        for i in 1...33 {
          let extureName = "New Piskel-\(i).png"
            compressFrames.append(SKTexture(imageNamed: extureName))
        }
        
        let appCompact = SKSpriteNode(imageNamed: "New Piskel-1.png")
        appCompact.scale(to: CGSize(width: 332 , height: 364))
        appCompact.zPosition = 11
        appCompact.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        appCompact.position = CGPoint(x: 50+appCompact.size.width/2, y: 130+appCompact.size.height/2)
        self.addChild(appCompact)
        
        let sequence = SKAction.sequence(
            [SKAction.animate(with: compressFrames, timePerFrame: 0.01),
             SKAction.scale(by: 0.25, duration: 0.25),
             SKAction.group(
                [
                    SKAction.scale(by: 0, duration: 0.35),
                SKAction.rotate(byAngle: 6, duration: 0.25),
                SKAction.move(to: CGPoint(x: self.size.width*4/6-5, y: 75), duration: 0.25)
                ]
             )
        ])
        
        appCompact.run(
            sequence
        )
    }
    
}
