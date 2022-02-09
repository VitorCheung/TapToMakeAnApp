//
//  GameSceneDocs.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 13/01/22.
//

import SpriteKit
import GameplayKit

class GameSceneDocs: SKScene {
    
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
        case "rank":
            vc.showGameLeaderBoard()
        case "officeIcon":
            if player.didTutorial[7]{
            player.setPlayerUserDefaults()
            self.view?.presentScene( GameSceneOffice(vc: vc)  )
            }
        case "teamIcon":
            if player.didTutorial[6]{
                player.setPlayerUserDefaults()
                self.view?.presentScene( GameSceneTeam(vc: vc)  )
            }
        case "Money":
            if player.didTutorial[7]{
            player.setPlayerUserDefaults()
            self.view?.presentScene( GameSceneShop(vc: vc)  )
            }
        case "serverIcon":
            if player.didTutorial[7]{
            player.setPlayerUserDefaults()
            self.view?.presentScene( GameSceneServe(vc: vc)  )
            }
        case "contrat":
            if !(activeAnimationBuy){
                
                guard let worker = Worker.library.randomElement()  else { return }
                
                if player.money >= player.priceDocs(){
                    
                    player.money -= player.priceDocs()
                    player.docsBuy += 1
                    setup()
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
        case "tutorial":

            if !player.didTutorial[5]{
                player.didTutorial[5].toggle()
                setup()
                break
            }
            if !player.didTutorial[6]{
                player.didTutorial[6].toggle()
                setup()
                break
            }

        default:
            return
        }
        
    }
    
    //MARK: Update
    override func update(_ currentTime: TimeInterval) {
        deadLineLabel.text = "Deadline: \(timerDeadLine.shared.deadLine) "+NSLocalizedString("days", comment: "")
        moneyLabel.text = "$\(Int64.numRedable(num:player.money))"
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
        
        if !player.didTutorial[5]{
            let tutorial = tutorialNode(text:  NSLocalizedString("Tutorial5", comment: ""))
            addChild(tutorial)
        }
        
        moneyLabel.fontColor = .black
        moneyLabel.zPosition = 10
        moneyLabel.fontName = "munro"
        moneyLabel.fontSize = 35
        moneyLabel.horizontalAlignmentMode = .left
        moneyLabel.position = CGPoint(x:10, y: self.size.height-30)
        self.addChild(moneyLabel)
        
        deadLineLabel.fontColor = .red
        deadLineLabel.zPosition = 10
        deadLineLabel.fontName = "munro"
        deadLineLabel.fontSize = 30
        deadLineLabel.horizontalAlignmentMode = .left
        deadLineLabel.position = CGPoint(x:10, y: self.size.height-55)
        self.addChild(deadLineLabel)
        
        let rankButtonNode = RankButtonNode()
        rankButtonNode.size = CGSize(width: 40, height: 40)
        rankButtonNode.position = CGPoint(x: self.size.width-30, y: self.size.height-30)
        self.addChild(rankButtonNode)
        
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
        
        terminalNode.setup()
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
                if !player.didTutorial[6]{
                    let tutorial = tutorialNode(text:  NSLocalizedString("Tutorial6", comment: ""))
                    addChild(tutorial)
                }
                isFirstAnimationDone = false
                activeAnimationBuy = false
                
            }
            
        }

    }
    
    func winAnimation(){
        
        var brilhoFramesDiagonal: [SKTexture] {
            var brilhoFrames : [SKTexture] = []
            for i in 0...9 {
              let extureName = "diagonal\(i)"
                brilhoFrames.append(SKTexture(imageNamed: extureName))
            }
            return brilhoFrames
        }
        
        var brilhoFramesVertigal: [SKTexture] {
            var brilhoFrames : [SKTexture] = []
            for i in 0...9 {
              let extureName = "eixo0\(i)"
                brilhoFrames.append(SKTexture(imageNamed: extureName))
            }
            return brilhoFrames
        }
        
        for i in 0...3 {
            let brilhoNodeDiagonal = SKSpriteNode(imageNamed: "diagonal0")
            brilhoNodeDiagonal.setScale(0.25)
            brilhoNodeDiagonal.zPosition = 0
            brilhoNodeDiagonal.zRotation = (.pi/2)*Double(i)
            brilhoNodeDiagonal.anchorPoint = CGPoint(x: 1, y: 0)
            brilhoNodeDiagonal.position = CGPoint(x: 205, y: 660)
            addChild(brilhoNodeDiagonal)
            brilhoNodeDiagonal.run( SKAction.repeatForever(
                SKAction.animate(with: brilhoFramesDiagonal, timePerFrame: 0.1)
                )
            )
            
            let brilhoNodeVertinal = SKSpriteNode(imageNamed: "eixo00")
            brilhoNodeVertinal.setScale(0.25)
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
                brilhoNodeStar.setScale(0.5)
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


