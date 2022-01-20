//
//  GameSceneDocs.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 13/01/22.
//

import SpriteKit
import GameplayKit

class GameSceneDocs: SKScene {
    
    //data
    var player = Player.shared
    
    //Nodes
    let moneyLabel = SKLabelNode()
    let deadLineLabel = SKLabelNode()
    let terminalNode = TerminalDocs()
    
    //Docs
    let imgDocs = SKSpriteNode(imageNamed: "docs")
    var isRotatingToRight = false
    var isFirstAnimationDone = false
    var activeAnimationBuy = false
    
    var workerWon: Worker? = nil
    
    override func didMove(to view: SKView) {
        // Set the scale mode to scale to fit the window
        self.scaleMode = .aspectFit
        // Set scene to phone size
        self.size = CGSize(width: 428 , height: 840)
    
        self.backgroundColor = .white
        
        //Difine de size of the scene
        self.anchorPoint = CGPoint(x: 0, y: 0)
        
        //Difine de size of the scene
        self.anchorPoint = CGPoint(x: 0, y: 0)

        setup()

    }
    
    //MARK: TouchesEnded
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch:UITouch = touches.first!
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
            print("docs")
        case "server":
            player.setPlayerUserDefaults()
            self.view?.presentScene( GameSceneServe() )
        case "contrat":
            if !(activeAnimationBuy){
                
                guard let worker = WorkersEnum.library.randomElement()  else { return }
                
                if player.money >= Int64(587*pow(Double(player.docsBuy),Double(2))+100){
                    
                    player.money -= Int64(587*pow(Double(player.docsBuy),Double(2))+100)
                    player.docsBuy += 1
                    self.setup()
                    activeAnimationBuy = true
                    workerWon = worker
                    
                    var indexTeam = 0
                    while  indexTeam < player.team.count {
                        if let name = player.team[indexTeam]?.name
                        {
                            if name == worker.name {
                                player.team[indexTeam]!.level += 1
                                break
                            }
                        }
                        indexTeam += 1
                    }
                    
                    var indexWorker = 0
                    while  indexWorker < player.workers.count {
                        if player.workers[indexWorker].name == worker.name {
                            player.workers[indexWorker].level += 1
                            break
                        }
                        indexWorker += 1
                    }
                    
                    if indexWorker == player.workers.count && indexTeam == player.team.count{
                        player.workers.append(worker)
                    }
                }
                
                    
            }
            player.setPlayerUserDefaults()
        default:
            return
        }
        
    }
    
    //MARK: Update
    override func update(_ currentTime: TimeInterval) {
        deadLineLabel.text = "Dead line: \(timerDeadLine.shared.deadLine) days"
        moneyLabel.text = "$\(player.money)"
        if activeAnimationBuy{
            animationBuy(worker: workerWon)
        }
        else{
            animationShake()
        }
        
    }
    
    
    func setup(){
        //MARK: Labels
        self.removeAllChildren()
        
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
        
        //MARK: ImgDocs
        
        imgDocs.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        imgDocs.position = CGPoint(x: 210, y: 660)
        imgDocs.size = CGSize(width: 185, height: 185)
        self.addChild(imgDocs)
        
        //MARK: Screem
        
        let screemNode = ScreemNode()
        screemNode.anchorPoint = CGPoint(x: 0, y: 0)
        screemNode.position = CGPoint( x: 0 , y: 0)
        screemNode.name = "screem"
        self.addChild(screemNode)
        
        terminalNode.zPosition = 1
        terminalNode.anchorPoint = CGPoint(x: 0, y: 0)
        terminalNode.position = CGPoint(x: 48, y: 117)
        addChild(terminalNode)
        
        
    }
    
    //MARK: animation
    func animationShake(){

        if isRotatingToRight {
            imgDocs.zRotation += 0.01
            if imgDocs.zRotation > 0.2 {isRotatingToRight = false}
        }
        else {
            imgDocs.zRotation -= 0.01
            if imgDocs.zRotation < -0.2 {isRotatingToRight = true}
        }

    }
    
    func animationBuy(worker:Worker?){
        
        guard let winWorker = worker else { return }
        
        if !(isFirstAnimationDone){
            
            if(imgDocs.xScale > 0){
                imgDocs.zRotation += 0.1
                imgDocs.xScale -= 0.01
                imgDocs.yScale -= 0.01
                return
            }
            
            isFirstAnimationDone = true
        }
        else {
            if (imgDocs.xScale < 1 ){
                imgDocs.texture = nil
                imgDocs.removeAllChildren()
                imgDocs.addChild(
                    WorkerNode(worker: winWorker)
                )
                imgDocs.zRotation = 0
                imgDocs.xScale += 0.1
                imgDocs.yScale += 0.1
                if winWorker.rarety==5{
                    starAnimation()
                    self.backgroundColor = ColorPalette.goldWin
                }
                else{
                    self.backgroundColor = .white
                }
                return
            }
            else{
                winAnimation()
                isFirstAnimationDone = false
                activeAnimationBuy = false
                
            }
            
        }

    }
    
    func winAnimation(){
        
        var brilhoFramesDiagonal: [SKTexture] {
            var brilhoFrames : [SKTexture] = []
            for i in 0...9 {
              let extureName = "Efeito-Diagonal\(i)"
                brilhoFrames.append(SKTexture(imageNamed: extureName))
            }
            return brilhoFrames
        }
        
        var brilhoFramesVertigal: [SKTexture] {
            var brilhoFrames : [SKTexture] = []
            for i in 0...9 {
              let extureName = "Efeito-Top\(i)"
                brilhoFrames.append(SKTexture(imageNamed: extureName))
            }
            return brilhoFrames
        }
        
        for i in 0...3 {
            let brilhoNodeDiagonal = SKSpriteNode(imageNamed: "Efeito-Diagonal0")
            brilhoNodeDiagonal.setScale(2)
            brilhoNodeDiagonal.zPosition = 0
            brilhoNodeDiagonal.zRotation = (.pi/2)*Double(i)
            brilhoNodeDiagonal.anchorPoint = CGPoint(x: 1, y: 0)
            brilhoNodeDiagonal.position = CGPoint(x: 205, y: 660)
            addChild(brilhoNodeDiagonal)
            brilhoNodeDiagonal.run( SKAction.repeatForever(
                SKAction.animate(with: brilhoFramesDiagonal, timePerFrame: 0.1)
                )
            )
            
            let brilhoNodeVertinal = SKSpriteNode(imageNamed: "Efeito-Top0")
            brilhoNodeVertinal.setScale(2)
            brilhoNodeVertinal.zPosition = 0
            brilhoNodeVertinal.zRotation = (.pi/2)*Double(i)
            brilhoNodeVertinal.anchorPoint = CGPoint(x: 0.5, y: 0)
            brilhoNodeVertinal.position = CGPoint(x: 205, y: 660)
            addChild(brilhoNodeVertinal)
            brilhoNodeVertinal.run( SKAction.repeatForever(
                SKAction.animate(with: brilhoFramesVertigal, timePerFrame: 0.1)
                )
            )
            
        }
        
    
    }
    
    func starAnimation(){
        
        var brilhoFramesStar: [SKTexture] {
            var brilhoFrames : [SKTexture] = []
            for i in 0...9 {
              let extureName = "star\(i)"
                brilhoFrames.append(SKTexture(imageNamed: extureName))
            }
            return brilhoFrames
        }
        for y in 0...1 {
            for x in 0...1 {
                let brilhoNodeStar = SKSpriteNode(imageNamed: "star0")
                brilhoNodeStar.setScale(4)
                brilhoNodeStar.zPosition = 0
                brilhoNodeStar.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                brilhoNodeStar.position = CGPoint(x: 100+x*200, y: 600+y*110)
                addChild(brilhoNodeStar)
                brilhoNodeStar.run( SKAction.repeatForever(
                    SKAction.animate(with: brilhoFramesStar, timePerFrame: 0.1)
                    )
                )
            }
        }
        
    }

}


