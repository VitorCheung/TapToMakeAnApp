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
    
    //Docs
    let imgDocs = SKSpriteNode(imageNamed: "docs")
    var isRotatingToRight = false
    var isFirstAnimationDone = false
    var activeAnimationBuy = false
    
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
            self.view?.presentScene( GameSceneOffice() )
        case "team":
            self.view?.presentScene( GameSceneTeam() )
        case "docs":
            print("docs")
        case "server":
            print("server")
        case "contrat":
            if !(activeAnimationBuy){
                guard var money = player.money else { return }
                guard let worker = WorkersEnum.library.randomElement()  else { return }
                if money >= 100{
                    money -= 100
                    player.workers.append(worker)
                    player.money = money
                    activeAnimationBuy = true
                }
                    
            }
        default:
            return
        }
        
    }
    
    //MARK: Update
    override func update(_ currentTime: TimeInterval) {
        deadLineLabel.text = "Dead line: \(player.deadLine) days"
        moneyLabel.text = "$\(player.money ?? 0)"
        if activeAnimationBuy{
            animationBuy(worker: player.workers.last)
        }
        else{
            animationShake()
        }
        
    }
    
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
                imgDocs.texture = SKTexture(imageNamed: winWorker.name)
                imgDocs.size = CGSize(width: 50, height: 141)
                imgDocs.zRotation = 0
                imgDocs.xScale += 0.1
                imgDocs.yScale += 0.1
                if winWorker.rarety==5{
                    self.backgroundColor = ColorPalette.goldWin
                }
                else{
                    self.backgroundColor = .white
                }
                return
            }
            

            isFirstAnimationDone = false
            activeAnimationBuy = false
            
        }

    }
    
    func setup(){

        //MARK: Labels
        
        moneyLabel.fontColor = .black
        moneyLabel.zPosition = 10
        moneyLabel.fontName = "Pixel"
        moneyLabel.fontSize = 25
        moneyLabel.text = "$\(player.money ?? 0)"
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
        
        let terminalNode = TerminalDocs()
        terminalNode.setup()
        terminalNode.zPosition = 1
        terminalNode.anchorPoint = CGPoint(x: 0, y: 0)
        terminalNode.position = CGPoint(x: 48, y: 117)
        addChild(terminalNode)
        
        
    }

}


