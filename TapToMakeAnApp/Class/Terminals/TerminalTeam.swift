//
//  TerminalTeam.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 11/01/22.
//

import SpriteKit

public class TerminalTeam: SKSpriteNode{
    
    let player = Player.shared
    
    public init(){
        super.init(texture: nil, color: ColorPalette.backgroundGray, size: CGSize(width: 332 , height: 364))
        name="terminal"
        self.zPosition = -1
        self.anchorPoint = CGPoint(x: 0, y: 0)
        setup()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setup(){
        removeAllChildren()
        var numberWorkers = player.workers.count
        let linesWorker = player.workers.count%3>0 ? Double(player.workers.count)/3+1 : Double(player.workers.count)/3
        
        for line in 0..<Int(linesWorker.rounded()){
            
            if numberWorkers-3>0 {
                for colum in 0...2 {
                    addWorker(x: CGFloat(66+100*colum), y: -80+self.size.height-CGFloat(140*line), indexWorker: numberWorkers-1)
                    numberWorkers -= 1
                }
                
            }
            else{
                for colum in 0..<numberWorkers{
                    addWorker(x: CGFloat(66+100*colum), y: -80+self.size.height-CGFloat(140*line), indexWorker: numberWorkers-1)
                    numberWorkers -= 1
                }
            }
        }
    }
    
    func addWorker(x:CGFloat, y:CGFloat,indexWorker: Int){
        let worker = SKSpriteNode(color: .clear, size: CGSize(width: 100, height: 140))
        worker.zPosition = 1
        worker.drawBorder(color: ColorPalette.mainGreen, width: 5)
        worker.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        worker.position = CGPoint(x: x, y: y)
        
        if let workerData = player.workers[indexWorker] {
            let imgWorker = WorkerNode(worker: workerData)
            imgWorker.zPosition = 0
            imgWorker.positonLibary = indexWorker
            imgWorker.scale(to: CGSize(width: 40, height: 85))
            imgWorker.position = CGPoint(x:0,y:0)
            imgWorker.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            
            worker.addChild(imgWorker)
        }

        
        self.addChild(worker)
        
        
    }
}
