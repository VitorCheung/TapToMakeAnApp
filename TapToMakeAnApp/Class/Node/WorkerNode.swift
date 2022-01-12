//
//  WorkerNode.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 11/01/22.
//

import SpriteKit

public class WorkeNode: SKSpriteNode{
    var imgName : String?
    public init(imgName:String?){
        
        self.imgName = imgName
        
        guard let img = self.imgName else {
            super.init(texture: nil, color: UIColor.clear, size: CGSize(width: 124, height: 124))
            name="noWorker"
            self.zPosition = -1
            return
        }
        
        let texture = SKTexture(imageNamed: img)
        super.init(texture: texture, color: UIColor.clear, size: CGSize(width: 124, height: 124))
        name=img
        self.zPosition = -1
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    
}
