//
//  Screem.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 10/01/22.
//

import SpriteKit

public class ScreemNode: SKSpriteNode{
    
    public init(){
        
        super.init(texture: nil, color: ColorPalette.backgroundGray, size: CGSize(width: 428, height: 537))
        
        zPosition = 2

        setup()


    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
    
        let botScreem = SKSpriteNode(imageNamed: "botPc.png")
        botScreem.zPosition = 3
        botScreem.anchorPoint =  CGPoint(x: 0, y:0)
        botScreem.position = CGPoint(x:0, y: 0)
        botScreem.size = CGSize(width: 428, height: 136)
        botScreem.name="screem"
        self.addChild(botScreem)
        
        let leftScreem = SKSpriteNode(imageNamed: "leftPc.png")
        leftScreem.zPosition = 3
        leftScreem.anchorPoint =  CGPoint(x: 0, y:0)
        leftScreem.position = CGPoint(x:0, y: 136)
        leftScreem.size = CGSize(width: 54, height: 355)
        leftScreem.name="screem"
        self.addChild(leftScreem)
        
        let rightScreem = SKSpriteNode(imageNamed: "rigthPc.png")
        rightScreem.zPosition = 3
        rightScreem.anchorPoint =  CGPoint(x: 0, y:0)
        rightScreem.position = CGPoint(x:377, y: 136)
        rightScreem.size = CGSize(width: 54, height: 355)
        rightScreem.name="screem"
        self.addChild(rightScreem)
        
        let topScreem = SKSpriteNode(imageNamed: "topPc.png")
        topScreem.zPosition = 3
        topScreem.anchorPoint =  CGPoint(x: 0, y:0)
        topScreem.position = CGPoint(x:0, y: 490)
        topScreem.size = CGSize(width: 428, height: 48)
        topScreem.name="screem"
        self.addChild(topScreem)
        
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

    }
}
