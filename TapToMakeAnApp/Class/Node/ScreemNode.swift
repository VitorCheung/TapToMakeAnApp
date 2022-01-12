//
//  Screem.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 10/01/22.
//

import SpriteKit

public class ScreemNode: SKSpriteNode{
    public init(){
        super.init(texture: nil, color: UIColor.clear, size: CGSize(width: 428, height: 537))
        name="screem"
        
        let screem = SKSpriteNode(imageNamed: "pc.png")
        screem.anchorPoint =  CGPoint(x: 0, y:0)
        screem.position = CGPoint(x:0, y: 0)
        screem.size = CGSize(width: 428, height: 537)
        self.addChild(screem)
        
        //MARK: button
        let buttonOffice = ButtonTabBarNode(img: "officeIcon", name: "office")
        let buttonTeam = ButtonTabBarNode(img: "teamIcon", name: "team")
        let buttonDoc = ButtonTabBarNode(img: "docIcon", name: "docs")
        let buttonServer = ButtonTabBarNode(img: "serverIcon", name: "server")
        
        buttonOffice.anchorPoint = CGPoint(x: 0, y: 0)
        buttonOffice.position = CGPoint(x: self.size.width*1/5-30, y: 40)
        self.addChild(buttonOffice)
        
        buttonTeam.anchorPoint = CGPoint(x: 0, y: 0)
        buttonTeam.position = CGPoint(x: self.size.width*2/5-30, y: 40)
        self.addChild(buttonTeam)
        
        buttonDoc.anchorPoint = CGPoint(x: 0, y: 0)
        buttonDoc.position = CGPoint(x: self.size.width*3/5-30, y: 40)
        self.addChild(buttonDoc)
        
        buttonServer.anchorPoint = CGPoint(x: 0, y: 0)
        buttonServer.position = CGPoint(x: self.size.width*4/5-30, y: 40)
        self.addChild(buttonServer)
        
        //MARK: border
        let border = SKSpriteNode(color: .clear, size: CGSize(width: 335, height: 371))
        border.drawBorder(color: ColorPalette.mainGreen, width: 8)
        border.zPosition = 3
        border.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        border.position = CGPoint(x: self.size.width/2, y: self.size.height/2+30)
        self.addChild(border)

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}