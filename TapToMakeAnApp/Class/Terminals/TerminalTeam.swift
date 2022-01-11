//
//  TerminalTeam.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 11/01/22.
//

import SpriteKit

public class TerminalTeam: SKSpriteNode{
    
    public init(){
        super.init(texture: nil, color: ColorPalette.backgroundGray, size: CGSize(width: 332 , height: 364))
        name="terminal"
        self.zPosition = -5
        self.anchorPoint = CGPoint(x: 0, y: 0)
        

        
            for colum in 0...2 {
               for linha in 0...2 {
                   addWorker(x: CGFloat(66+100*linha), y: -80+self.size.height-CGFloat(140*colum))
                }
            }

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addWorker(x:CGFloat, y:CGFloat){
        let worker = SKSpriteNode(color: .clear, size: CGSize(width: 100, height: 140))
        worker.drawBorder(color: ColorPalette.mainGreen, width: 5)
        worker.anchorPoint = CGPoint(x: 0.5, y: 1)
        worker.position = CGPoint(x: x, y: y)
        self.addChild(worker)
        
    }
}
