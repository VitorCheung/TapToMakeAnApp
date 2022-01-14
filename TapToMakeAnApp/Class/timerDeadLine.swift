//
//  Player.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 11/01/22.
//

import Foundation

class timerDeadLine{
    
    var player = Player.shared
    
    static var shared = timerDeadLine()
    
    lazy var deadLine = player.deadLine
    var timer = Timer()
    var isDeadLineEnded = false
    var firstCliked = true
    
    //MARK: Timer
    func starCounter(){
        if firstCliked{
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(decrementCounter), userInfo: nil, repeats: true)
        }
    }
    
    @objc func decrementCounter(){
        player.money += player.totalEarning()
        
        if firstCliked{
            return
        }
        
        if deadLine>0 {
        deadLine -= 1
        }
        else{
            isDeadLineEnded = true
        }
    }
    
}
