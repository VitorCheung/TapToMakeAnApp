//
//  WorkerNode.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 11/01/22.
//

import SpriteKit

public class WorkerNode: SKSpriteNode{
    public var worker : Worker?
    public var positonLibary : Int?
    public init(worker:Worker?){
        
        positonLibary = nil
        self.worker = worker
        
        guard let img = worker?.name else {
            super.init(texture: nil, color: UIColor.clear, size: CGSize(width: 124, height: 124))
            name="worker"
            return
        }
        
        let texture = SKTexture(imageNamed: img)
        super.init(texture: texture, color: UIColor.clear, size: CGSize(width: 124, height: 124))
        name="worker"
        self.zPosition = 4
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    
}
