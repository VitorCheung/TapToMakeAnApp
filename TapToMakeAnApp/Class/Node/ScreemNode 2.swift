//
//  Screem.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 10/01/22.
//

import SpriteKit

public class ScreemNode: SKSpriteNode{
    
    var terminal : SKSpriteNode
    
    public init(terminal: SKSpriteNode){
        
        self.terminal = terminal
        super.init(texture: nil, color: ColorPalette.backgroundGray, size: CGSize(width: 428, height: 537))
        
        name="screem"
        zPosition = 2

        setup()


    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateTerminal(terminal: SKSpriteNode){
        self.terminal = terminal
        
        removeAllChildren()
        setup()
    }
    

    func setup(){
        let screem = SKSpriteNode(imageNamed: "pc.png")
        screem.zPosition = 3
        screem.anchorPoint =  CGPoint(x: 0, y:0)
        screem.position = CGPoint(x:0, y: 0)
        screem.size = CGSize(width: 428, height: 537)
        screem.name="screem"
        self.addChild(screem)
        
        //MARK: button
        let buttonOffice = ButtonTabBarNode(img: "officeIcon", name: "office")
        let buttonTeam = ButtonTabBarNode(img: "teamIcon", name: "team")
        let buttonDoc = ButtonTabBarNode(img: "docIcon", name: "docs")
        let buttonServer = ButtonTabBarNode(img: "serverIcon", name: "server")
        
        buttonOffice.zPosition = 4
        buttonOffice.anchorPoint = CGPoint(x: 0, y: 0)
        buttonOffice.position = CGPoint(x: self.size.width*1/5-30, y: 40)
        self.addChild(buttonOffice)
        
        buttonTeam.zPosition = 4
        buttonTeam.anchorPoint = CGPoint(x: 0, y: 0)
        buttonTeam.position = CGPoint(x: self.size.width*2/5-30, y: 40)
        self.addChild(buttonTeam)
        
        buttonDoc.zPosition = 4
        buttonDoc.anchorPoint = CGPoint(x: 0, y: 0)
        buttonDoc.position = CGPoint(x: self.size.width*3/5-30, y: 40)
        self.addChild(buttonDoc)
        
        buttonServer.zPosition = 4
        buttonServer.anchorPoint = CGPoint(x: 0, y: 0)
        buttonServer.position = CGPoint(x: self.size.width*4/5-30, y: 40)
        self.addChild(buttonServer)
        
        //MARK: border
        let border = SKSpriteNode(color: .clear, size: CGSize(width: 335, height: 371))
        border.drawBorder(color: ColorPalette.mainGreen, width: 8)
        border.zPosition = 2
        border.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        border.position = CGPoint(x: self.size.width/2, y: self.size.height/2+30)
        self.addChild(border)

        //MARK: Terminal
        if let terminalNode = terminal as? TerminalTeam {
            terminalNode.setup()
            terminalNode.zPosition = 1
            terminalNode.anchorPoint = CGPoint(x: 0, y: 0)
            terminalNode.position = CGPoint(x: 48, y: 117)

            self.addChild(terminalNode)
        }
        else if let terminalNode = terminal as? TerminalOffice{
            terminalNode.setTerminalClicker()
            terminalNode.zPosition = 1
            terminalNode.anchorPoint = CGPoint(x: 0, y: 0)
            terminalNode.position = CGPoint(x: 48, y: 117)

            self.addChild(terminalNode)
        }
        else if let terminalNode = terminal as? TerminalResults{
            terminalNode.setup()
            terminalNode.zPosition = 1
            terminalNode.anchorPoint = CGPoint(x: 0, y: 0)
            
            self.addChild(terminalNode)
            
        }
    }
}
