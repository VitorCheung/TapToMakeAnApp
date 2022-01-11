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
    
    // declarar class Worker
    var worker1 = SKSpriteNode(imageNamed: "Muza")
    var worker2 = SKSpriteNode(imageNamed: "Ju")
    var worker3 = SKSpriteNode(imageNamed: "Marcus")
    
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
        
        //Difine de size of the scene
        self.anchorPoint = CGPoint(x: 0, y: 0)

        //MARK: Labels
        
        moneyLabel.fontColor = .black
        moneyLabel.fontName = "Pixel"
        moneyLabel.fontSize = 25
        moneyLabel.text = "$\(player.money ?? 0)"
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
        
        worker1.anchorPoint = CGPoint(x: 1, y: 0)
        worker1.position = CGPoint( x: self.size.width*3/20, y: 550)
        worker1.scale(to: CGSize(width: 48, height: 141))
        self.addChild(worker1)
        
        worker2.anchorPoint = CGPoint(x: 1, y: 0)
        worker2.position = CGPoint( x: self.size.width/2-10, y: 550)
        worker2.scale(to: CGSize(width: 48, height: 141))
        self.addChild(worker2)
        
        worker3.anchorPoint = CGPoint(x: 1, y: 0)
        worker3.position = CGPoint( x: self.size.width*17/20-10 , y: 550)
        worker3.scale(to: CGSize(width: 48, height: 141))
        self.addChild(worker3)
        
        //MARK: Desks
        let desk1 = Desk()
        let desk2 = Desk()
        let desk3 = Desk()
        
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
        let backgroundNode = Background()
        
        backgroundNode.anchorPoint = CGPoint(x: 0.5, y: 0)
        backgroundNode.position = CGPoint( x: self.size.width/2, y: 500)
        self.addChild(backgroundNode)
        
        //MARK: windows
        let window1 = Window()
        let window2 = Window()
        
        window1.anchorPoint = CGPoint(x: 0.75, y: 0)
        window1.position = CGPoint(x: self.size.width*1/3, y: 650)
        self.addChild(window1)
        
        window2.anchorPoint = CGPoint(x: 0.25, y: 0)
        window2.position = CGPoint(x: self.size.width*2/3, y: 650)
        self.addChild(window2)
        
        //MARK: Screem
        let screemNode = Screem()
        
        screemNode.anchorPoint = CGPoint(x: 0, y: 0)
        screemNode.position = CGPoint( x: 0 , y: 0)
        self.addChild(screemNode)
        
        //MARK: Terminal
        terminalNode.zPosition = 4
        terminalNode.anchorPoint = CGPoint(x: 0, y: 0)
        terminalNode.position = CGPoint(x: 48, y: 117)
        self.addChild(terminalNode)
        

    }
    
    //MARK: TouchesEnded
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch:UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        
        switch touchedNode.name{
        case "office":
            self.view?.presentScene( GameSceneOffice())
        case "team":
            print("team")
        case "docs":
            print("docs")
        case "server":
            print("server")
        default:
            return
        }
        
    }
    
    //MARK: Update
    override func update(_ currentTime: TimeInterval) {
        deadLineLabel.text = "Dead line: \(player.deadLine) days"
        
    }
    

}

