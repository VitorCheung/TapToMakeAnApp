//
//  Player.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 11/01/22.
//

import Foundation

public class Player{
    
    static var shared = Player()
    
    var money : Int?
    var points : Int?
    var workers : [Worker] = []
    var team : [Worker?] = [nil,nil,nil]
    var firstCliked = true
    var apps : [App?] = []
    
    //timer
    var deadLine = 10
    var timerDeadLine = Timer()
    var deadLineStart = 10
    var isDeadLineEnded = false
    
    
    //MARK: Timer
    func starCounter(){
        timerDeadLine = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(decrementCounter), userInfo: nil, repeats: true)
    }
    
    @objc func decrementCounter(){
        if(deadLine>0){
        deadLine -= 1
        }
        else{
            isDeadLineEnded = true
            timerDeadLine.invalidate()
        }
    }
}
