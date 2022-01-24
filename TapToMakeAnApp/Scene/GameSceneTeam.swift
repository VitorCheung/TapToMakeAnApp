//
//  GameSceneTeam.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 11/01/22.
//

import SpriteKit
import GameplayKit

class GameSceneTeam: SKScene {
    
    //data
    var player = Player.shared
    
    //Nodes
    let moneyLabel = SKLabelNode()
    let deadLineLabel = SKLabelNode()
    var terminalNode = TerminalTeam()
    
    var isToucheMoved = false
    
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
            let touch:UITouch = touches.first!
            let positionInScene = touch.location(in: self)
            let touchedNode = self.atPoint(positionInScene)
            switch touchedNode.name{
            case "office":
                player.setPlayerUserDefaults()
                self.view?.presentScene( GameSceneOffice() )
            case "shop":
                player.setPlayerUserDefaults()
                self.view?.presentScene( GameSceneShop() )
            case "docs":
                player.setPlayerUserDefaults()
                self.view?.presentScene( GameSceneDocs() )
            case "server":
                player.setPlayerUserDefaults()
                self.view?.presentScene( GameSceneServe() )
            case "worker":
                let workerNode = touchedNode as? WorkerNode
                addWorkerToTeam(worker: workerNode?.worker, positionInLibary: workerNode?.positonLibary)
                player.setPlayerUserDefaults()
            case "remove1":
                removeWorkerOfTeam(position: 0)
                player.setPlayerUserDefaults()
            case "remove2":
                removeWorkerOfTeam(position: 1)
                player.setPlayerUserDefaults()
            case "remove3":
                removeWorkerOfTeam(position: 2)
                player.setPlayerUserDefaults()
            case "info":
                let infoButton = touchedNode as? InfoButton
                terminalNode.setupInfo(worker: infoButton?.worker)
            case "back":
                terminalNode.setupSelection()
            default:
                return
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
            if terminalNode.isSelectonOpen {
                let linesWorker = player.workers.count%3>0 ? Double(player.workers.count)/3+1 : Double(player.workers.count)/3
                if terminalNode.position.y + deltaY > 100 && terminalNode.position.y  + deltaY < 140*linesWorker.rounded() {
                    terminalNode.position.y += deltaY
                }
            }
            else{
                if terminalNode.position.y + deltaY > 100 && terminalNode.position.y  + deltaY < 200 {
                    terminalNode.position.y += deltaY
                }
            }

        }
    }
    
    func addWorkerToTeam(worker:Worker?, positionInLibary: Int?){
        guard let index = positionInLibary else { return  }
        for position in 0..<player.team.count {
            if player.team[position] == nil{
                player.team[position] = worker
                player.workers.remove(at: index)
                break
            }
        }
        self.removeAllChildren()
        setup()
    }
    
    func removeWorkerOfTeam(position:Int){
        guard let worker = player.team[position] else { return  }
        player.workers.append(worker)
        player.team[position] = nil
        
        self.removeAllChildren()
        setup()
    }
    
    func setup(){

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
        
        //MARK: WORKER
        let buttonMinus1 = SKSpriteNode(imageNamed: "removeIcon")
        let buttonMinus2 = SKSpriteNode(imageNamed: "removeIcon")
        let buttonMinus3 = SKSpriteNode(imageNamed: "removeIcon")
        
        let worker1 = WorkerNode(worker: player.team[0])
        let worker2 = WorkerNode(worker: player.team[1])
        let worker3 = WorkerNode(worker: player.team[2])
        

        worker1.zPosition = 6
        worker1.position = CGPoint( x: self.size.width*3/20-20, y: 630)
        self.addChild(worker1)
        
        worker2.position = CGPoint( x: self.size.width/2-20, y: 630)
        worker2.zPosition = 6
        self.addChild(worker2)
        
        worker3.position = CGPoint( x: self.size.width*17/20-20 , y: 630)
        worker3.zPosition = 6
        self.addChild(worker3)
        
        if worker1.worker != nil {
            buttonMinus1.zPosition = 10
            buttonMinus1.name = "remove1"
            buttonMinus1.anchorPoint = CGPoint(x: 1, y: 0)
            buttonMinus1.position = CGPoint( x: self.size.width*3/20+30, y: 691)
            buttonMinus1.scale(to: CGSize(width: 30, height: 30))
            self.addChild(buttonMinus1)
        }

        if worker2.worker != nil {
            buttonMinus2.zPosition = 10
            buttonMinus2.name = "remove2"
            buttonMinus2.anchorPoint = CGPoint(x: 1, y: 0)
            buttonMinus2.position = CGPoint( x: self.self.size.width/2+30, y: 691)
            buttonMinus2.scale(to: CGSize(width: 30, height: 30))
            self.addChild(buttonMinus2)
        }
            
        if worker3.worker != nil {
            buttonMinus3.zPosition = 10
            buttonMinus3.name = "remove3"
            buttonMinus3.anchorPoint = CGPoint(x: 1, y: 0)
            buttonMinus3.position = CGPoint( x: self.size.width*17/20+30, y: 691)
            buttonMinus3.scale(to: CGSize(width: 30, height: 30))
            self.addChild(buttonMinus3)
        }
            
        //MARK: Desks
        let desk1 = DeskNode()
        let desk2 = DeskNode()
        let desk3 = DeskNode()
        
        desk1.anchorPoint = CGPoint(x: 0.5, y: 0)
        desk1.position = CGPoint( x: self.size.width*3/20+20, y: 550)
        desk1.zPosition = 7
        self.addChild(desk1)
        
        desk2.anchorPoint = CGPoint(x: 0.5, y: 0)
        desk2.position = CGPoint( x: self.size.width/2+20, y: 550)
        desk2.zPosition = 7
        self.addChild(desk2)
        
        desk3.anchorPoint = CGPoint(x: 0.5, y: 0)
        desk3.position = CGPoint( x: self.size.width*17/20+20 , y: 550)
        desk3.zPosition = 7
        self.addChild(desk3)
        
        //MARK: Bg
        let backgroundNode = BackgroundNode()
        let whiteBackgroundNode = SKSpriteNode(color: .white, size: CGSize(width: 428, height: 300))
        
        whiteBackgroundNode.zPosition = 4
        whiteBackgroundNode.anchorPoint = CGPoint(x: 0.5, y: 0)
        whiteBackgroundNode.position = CGPoint( x: self.size.width/2, y: 600)
        self.addChild(whiteBackgroundNode)
        
        backgroundNode.anchorPoint = CGPoint(x: 0.5, y: 0)
        backgroundNode.position = CGPoint( x: self.size.width/2, y: 500)
        backgroundNode.zPosition = 5
        self.addChild(backgroundNode)
        
        //MARK: windows
        let window1 = WindowNode()
        let window2 = WindowNode()
        
        window1.anchorPoint = CGPoint(x: 0.75, y: 0)
        window1.position = CGPoint(x: self.size.width*1/3, y: 650)
        window1.zPosition = 5
        self.addChild(window1)
        
        window2.anchorPoint = CGPoint(x: 0.25, y: 0)
        window2.position = CGPoint(x: self.size.width*2/3, y: 650)
        window2.zPosition = 5
        self.addChild(window2)
        
        //MARK: Screem
        
        let screemNode = ScreemNode()
        screemNode.anchorPoint = CGPoint(x: 0, y: 0)
        screemNode.position = CGPoint( x: 0 , y: 0)
        screemNode.name = "screem"
        self.addChild(screemNode)
        
        terminalNode.setupSelection()
        terminalNode.zPosition = 1
        terminalNode.anchorPoint = CGPoint(x: 0, y: 0)
        terminalNode.position = CGPoint(x: 48, y: 117)
        addChild(terminalNode)
        
        
    }

}

