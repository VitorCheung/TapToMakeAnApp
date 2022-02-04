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
    public init(worker:Worker?, scaleImgWorker: CGFloat = 0.4){
        
        positonLibary = nil
        self.worker = worker
        super.init(texture: nil, color: .clear, size: CGSize(width: 124, height: 124))
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        guard let img = worker?.name else {
            name="worker"
            return
        }
        
        let workerImg = SKSpriteNode(imageNamed: img)
        workerImg.position = CGPoint(x: 0, y: 0)
        workerImg.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        workerImg.setScale(scaleImgWorker)
        self.addChild(workerImg)
        
        name="worker"
        self.zPosition = 4
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    
}
