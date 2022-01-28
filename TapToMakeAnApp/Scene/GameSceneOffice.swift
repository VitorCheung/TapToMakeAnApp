//
//  GameScene.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 07/01/22.
//

import SpriteKit
import GameplayKit

class GameSceneOffice: SKScene {
    
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
            case "rank":
                vc.showGameLeaderBoard()
            case "storeLabel":
                if !player.didTutorial[2]{
                    player.didTutorial[2].toggle()
                }
                timer.deadLine = player.deadLine
                timer.isDeadLineEnded = false
                terminalNode.setupForCliker()
                player.apps.append(App(points: player.points))
                player.points = 0
                addToServerAnamation()
                player.setPlayerUserDefaults()
            case "sellLabel":
                if (player.didTutorial[0] && !player.didTutorial[1]) || player.didTutorial[3]{
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
                    ManagerGameCenter.setHighScore(score: Player.shared.money)
                }
            case "team":
                if player.didTutorial[3]{
                    player.setPlayerUserDefaults()
                    self.view?.presentScene( GameSceneTeam(vc: vc) )
                }
            case "docs":
                if player.didTutorial[3]{
                    player.setPlayerUserDefaults()
                    self.view?.presentScene( GameSceneDocs(vc: vc)  )
                }
            case "server":
                if player.didTutorial[2]{
                    player.setPlayerUserDefaults()
                    self.view?.presentScene( GameSceneServe(vc: vc)  )
                }
            case "shop":
                if player.didTutorial[3]{
                    player.setPlayerUserDefaults()
                    self.view?.presentScene( GameSceneShop(vc: vc) )
                }
            case "tutorial":
                if !(player.didTutorial[0]){
                    player.didTutorial[0].toggle()
                    setup()
                    break
                }
                if player.didTutorial[1]{
                    setup()
                    break
                }
                
                
                
            default:
                if player.didTutorial[0]{
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
        
    }
    
    //MARK: Update
    override func update(_ currentTime: TimeInterval) {
        
        terminalNode.pointsLabel.text = "POINTS: \(Int64.numRedable(num: Int64(player.points)))"
        deadLineLabel.text = "Dead line: \(timer.deadLine) days"
        moneyLabel.text = "$\(Int64.numRedable(num: player.money))"
        //        if points%5==0 {
        //            //jump worker
        //        }
        
        if timer.isDeadLineEnded{
            player.setPlayerUserDefaults()
            
            if player.apps.count < player.serverSpace && player.points != 0{
                if !(player.didTutorial[1]){
                    let tutorial = tutorialNode(text: "Excellent!!\nYou have developed your\nfirst app! Now tap on\nSTORE APP to store the \napp!")
                    addChild(tutorial)
                    player.didTutorial[1] = true
                }
                terminalNode.setupForResults(text: "STORE APP", name: "storeLabel")
            }
            else{
                let app = App(points: player.points)
                terminalNode.setupForResults(text: "SELL: \(Int64.numRedable(num: app.money))", name: "sellLabel")
            }
            return
        }
        
        
        
    }
    
    func setup(){
        removeAllChildren()
        //MARK: Labels
        if player.didTutorial[0]{
            timer.starCounter()
        }
        else{
            
            let tutorial = tutorialNode(text: "Hello, you must be the\nnew CEO!\nGreat, my name is japa\nI am here to help you\nget started!\nFirst thing, tap as much\nas you can on the\nscreem to gain points!")
            addChild(tutorial)
        }
        
        moneyLabel.fontColor = .black
        moneyLabel.fontName = "munro"
        moneyLabel.fontSize = 35
        moneyLabel.text = "$\(player.money)"
        moneyLabel.horizontalAlignmentMode = .left
        moneyLabel.position = CGPoint(x:10, y: self.size.height-30)
        self.addChild(moneyLabel)
        
        deadLineLabel.fontColor = .red
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
        labelPoints.fontName = "munro"
        labelPoints.fontSize = 35
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
             ),
             SKAction.run {
                 if !self.player.didTutorial[3]{
                     let tutorial = tutorialNode(text: "Nice!!\nNow go to the servers\nto see how your app\nis doing.")
                     self.addChild(tutorial)
                 }
             }
            ])
        
        appCompact.run(
            sequence
        )
    }
    
}
