//
//  TerminalTeam.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 11/01/22.
//

import SpriteKit

public class TerminalTeam: SKSpriteNode{
    
    var player = Player.shared
    var isSelectonOpen = true
    
    public init(){
        super.init(texture: nil, color: ColorPalette.backgroundGray, size: CGSize(width: 332 , height: 364))
        name="terminal"
        self.zPosition = -1
        self.anchorPoint = CGPoint(x: 0, y: 0)        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupInfo(worker: Worker?){
        removeAllChildren()
        
        isSelectonOpen = false
        
        let backButton = SKSpriteNode(imageNamed: "backIcon")
        backButton.name = "back"
        backButton.zPosition = 2
        backButton.scale(to: CGSize(width: 40, height: 40))
        backButton.position = CGPoint(x: 45, y: self.size.height-25)
        self.addChild(backButton)
        
        guard let w = worker else { return  }
        
        let nameLabel = SKLabelNode()
        nameLabel.fontColor = ColorPalette.mainGreen
        nameLabel.fontName = "munro"
        nameLabel.zPosition = 1
        nameLabel.fontSize = 35
        nameLabel.text = w.name
        nameLabel.horizontalAlignmentMode = .left
        nameLabel.position = CGPoint(x: self.size.width/2-75, y: self.size.height-30)
        self.addChild(nameLabel)
        
        let rarityLabel = SKLabelNode()
        rarityLabel.fontColor = ColorPalette.mainGreen
        rarityLabel.fontName = "munro"
        rarityLabel.zPosition = 1
        rarityLabel.fontSize = 27
        rarityLabel.text = "RARITY: "
        rarityLabel.horizontalAlignmentMode = .left
        rarityLabel.position = CGPoint(x: self.size.width/2-75, y: self.size.height-60)
        self.addChild(rarityLabel)
        
        for stars in 0..<w.rarety {
            addStar(x: self.size.width/2+40+CGFloat(25*stars), y:self.size.height-60, size: CGSize(width: 20, height: 20), node: self)
        }
        
        let powerLabel = SKLabelNode()
        powerLabel.fontColor = ColorPalette.mainGreen
        powerLabel.fontName = "munro"
        powerLabel.zPosition = 1
        powerLabel.fontSize = 27
        powerLabel.text = "POWER: \(w.power*w.level)/click"
        powerLabel.horizontalAlignmentMode = .left
        powerLabel.position = CGPoint(x: self.size.width/2-75, y: self.size.height-90)
        self.addChild(powerLabel)
        
        if (w.workerType[0]) != nil {
            
            let borderType1 = SKSpriteNode(color: .clear, size: CGSize(width: 235, height: 30))
            borderType1.zPosition = 1
            borderType1.anchorPoint = CGPoint(x: 0, y: 0)
            borderType1.drawBorder(color: ColorPalette.mainGreen, width: 3)
            borderType1.position = CGPoint(x: self.size.width/2-80, y: self.size.height-150)
            self.addChild(borderType1)
            
            let type1Label = SKLabelNode()
            type1Label.fontColor = ColorPalette.mainGreen
            type1Label.fontName = "munro"
            type1Label.zPosition = 1
            type1Label.fontSize = 23
            type1Label.text = w.workerType[0]
            type1Label.horizontalAlignmentMode = .left
            type1Label.position = CGPoint(x: self.size.width/2-75, y: self.size.height-140)
            self.addChild(type1Label)
            
            let type1DescriptionLabel = SKLabelNode()
            type1DescriptionLabel.fontColor = ColorPalette.mainGreen
            type1DescriptionLabel.fontName = "munro"
            type1DescriptionLabel.zPosition = 1
            type1DescriptionLabel.fontSize = 23
            type1DescriptionLabel.numberOfLines = 0
            type1DescriptionLabel.text = WorkerType.getDescription(name: w.workerType[0] ?? "")
            type1DescriptionLabel.horizontalAlignmentMode = .left
            type1DescriptionLabel.position = CGPoint(x: self.size.width/2-75, y: self.size.height-230)
            self.addChild(type1DescriptionLabel)
        }
        
        if (w.workerType[1]) != nil {
            let type2Label = SKLabelNode()
            type2Label.fontColor = ColorPalette.mainGreen
            type2Label.fontName = "munro"
            type2Label.zPosition = 1
            type2Label.numberOfLines = 0
            type2Label.fontSize = 23
            type2Label.text = w.workerType[1]
            type2Label.horizontalAlignmentMode = .left
            type2Label.position = CGPoint(x: self.size.width/2-75, y: self.size.height-280)
            self.addChild(type2Label)
            
            let borderType2 = SKSpriteNode(color: .clear, size: CGSize(width: 235, height: 30))
            borderType2.zPosition = 1
            borderType2.anchorPoint = CGPoint(x: 0, y: 0)
            borderType2.drawBorder(color: ColorPalette.mainGreen, width: 3)
            borderType2.position = CGPoint(x: self.size.width/2-80, y: self.size.height-280)
            self.addChild(borderType2)
            
            let type2DescriptionLabel = SKLabelNode()
            type2DescriptionLabel.fontColor = ColorPalette.mainGreen
            type2DescriptionLabel.fontName = "munro"
            type2DescriptionLabel.zPosition = 1
            type2DescriptionLabel.numberOfLines = 0
            type2DescriptionLabel.fontSize = 23
            type2DescriptionLabel.text = WorkerType.getDescription(name: w.workerType[1] ?? "")
            type2DescriptionLabel.horizontalAlignmentMode = .left
            guard let numbersOfWords = type2DescriptionLabel.text?.count else { return }
            let numberOfLines: Double = Double(numbersOfWords)/19
            type2DescriptionLabel.position = CGPoint(x: self.size.width/2-75, y:
                                                self.size.height-320-CGFloat(numberOfLines.rounded(.up)*15))
  
            self.addChild(type2DescriptionLabel)
        }
        
        let imgWorker = WorkerNode(worker: worker)
        imgWorker.zPosition = 1
        imgWorker.position = CGPoint(x:40,y:self.size.height/2)
        self.addChild(imgWorker)

        
    }
    
    public func setupSelection(){
        removeAllChildren()
        
        isSelectonOpen = true
        
        var numberWorkers = player.workers.count
        let linesWorker = player.workers.count%3>0 ? Double(player.workers.count)/3+1 : Double(player.workers.count)/3
        
        let boaderBonus = SKSpriteNode(color: .clear, size: CGSize(width: 300, height: 80))
        boaderBonus.zPosition = 1
        boaderBonus.drawBorder(color: ColorPalette.mainGreen, width: 5)
        boaderBonus.anchorPoint = CGPoint(x: 0, y: 0.5)
        boaderBonus.position = CGPoint(x:self.size.width/2, y: self.size.height-30)
        self.addChild(boaderBonus)
        
        let bonusLabel = SKLabelNode()
        bonusLabel.fontColor = ColorPalette.mainGreen
        bonusLabel.zPosition = 1
        bonusLabel.fontName = "munro"
        bonusLabel.fontSize = 25
        bonusLabel.numberOfLines = 0
        bonusLabel.text = activedBonus()
        bonusLabel.horizontalAlignmentMode = .left
        guard let numbersOfWords = bonusLabel.text?.count else { return }
        let numberOfLines: Double = Double(numbersOfWords)/19
        bonusLabel.position = CGPoint(x:-boaderBonus.size.width/2+10, y: -numberOfLines*20)
        boaderBonus.addChild(bonusLabel)
        
        for line in 0..<Int(linesWorker.rounded()){
            
            if numberWorkers-3>0 {
                for colum in 0...2 {
                    addWorker(x: CGFloat(66+100*colum), y: -160+self.size.height-CGFloat(140*line), indexWorker: numberWorkers-1)
                    numberWorkers -= 1
                }
                
            }
            else{
                for colum in 0..<numberWorkers{
                    addWorker(x: CGFloat(66+100*colum), y: -160+self.size.height-CGFloat(140*line), indexWorker: numberWorkers-1)
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
        
        let levelLabel = SKLabelNode()
        levelLabel.fontColor = ColorPalette.mainGreen
        levelLabel.fontName = "munro"
        levelLabel.zPosition = 1
        levelLabel.fontSize = 23
        levelLabel.text = "X\(player.workers[indexWorker].level)"
        levelLabel.horizontalAlignmentMode = .left
        levelLabel.position = CGPoint(x: -worker.size.width/2+5, y: worker.size.height/2-23)
        worker.addChild(levelLabel)
        
        let backgroundWorker = WorkerNode(worker: nil)
        backgroundWorker.zPosition = 1
        backgroundWorker.positonLibary = indexWorker
        backgroundWorker.worker = player.workers[indexWorker]
        backgroundWorker.scale(to: CGSize(width: 100, height: 140))
        backgroundWorker.position = CGPoint(x:0,y:0)
        backgroundWorker.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        worker.addChild(backgroundWorker)

        let imgWorker = WorkerNode(worker: player.workers[indexWorker],scaleImgWorker: 0.3)
        imgWorker.zPosition = 0
        imgWorker.positonLibary = indexWorker
        imgWorker.position = CGPoint(x:0,y:0)
        imgWorker.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            
        worker.addChild(imgWorker)
        
        let iconInfo = InfoButton(worker: player.workers[indexWorker])
        iconInfo.position = CGPoint(x:worker.size.width/2-30,y:worker.size.height/2-30)
        worker.addChild(iconInfo)
        
        for stars in 0..<player.workers[indexWorker].rarety {
            addStar(x: -(worker.size.width/2)+10+CGFloat(15*stars), y:-(worker.size.height/2)+5, size: CGSize(width: 14, height: 14), node: worker)
        }

        
        self.addChild(worker)
        
        
    }
    
    func addStar(x:CGFloat,y:CGFloat,size:CGSize,node:SKNode){
        let star = SKSpriteNode(imageNamed: "starIcon")
        star.zPosition = 1
        star.scale(to: size)
        star.anchorPoint = CGPoint(x: 0, y: 0)
        star.position = CGPoint(x: x, y: y)
        node.addChild(star)
    }
    
    func activedBonus()->String{
        var bonusString = "Bonus: "
        for wt in EnumWorkweType3.allCases {
            if player.bonus3(workerType: wt.rawValue){
                if bonusString == "Bonus: "{
                    bonusString += "\(wt.rawValue)\n"
                }
                else{
                    bonusString += "\(wt.rawValue) "
                }
            }
        }
        for wt in EnumWorkweType2.allCases {
            if player.bonus2(workerType: wt.rawValue){
                if bonusString == "Bonus: "{
                    bonusString += "\(wt.rawValue)\n"
                }
                else{
                    bonusString += "\(wt.rawValue) "
                }
            }
        }
        return bonusString
    }
    
}
