//
//  Player1.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 14/01/22.
//

import Foundation

class Player: Codable{
    
    static var shared = Player()
    
    var money : Int64 = 0
    var points : Int = 0
    var workers : [Worker] = []
    var team : [Worker?] = [nil,nil,nil]
    var apps : [App?] = []
    var deadLine : Int{
        if bonus(workerType: WorkersTypeEnum.Host){
            return 15
        }
        else{
            return 10
        }
    }
    var docsBuy = 0

    func totalEarning()->Int64{
        var earningTotal: Int64 = 0
            for app in apps {
                guard let appEarning = app?.earning else { return 0 }
                earningTotal += appEarning
            }
        return earningTotal
    }
    
    func clickPower()->Int{
        var clickPower = 1
        for work in team{
            if let power = work?.power {
                clickPower += power*(work?.level ?? 1)
            }
        }
        
        if bonus(workerType: WorkersTypeEnum.Designer){
            clickPower += 15
        }
        
        if bonus(workerType: WorkersTypeEnum.Coder){
            return clickPower*2
        }
        else{
            return clickPower
        }
        
    }
    
    func bonus(workerType:WorkerType)->Bool{
        var worker = 0
        for members in team {
            if let m = members {
                for wt in m.workerType {
                    if wt?.name == workerType.name{
                        worker += 1
                    }
                }
            }
        }
        if worker == 3 {
            return true
        }
        else{
            return false
        }
    }
    
    func setPlayerUserDefaults(){
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()

            // Encode Note
            let data = try encoder.encode(self)

            // Write/Set Data
            UserDefaults.standard.set(data, forKey: "player")

        } catch {
            print("Unable to Encode Array of Notes (\(error))")
        }
    }
    
    static func getPlayerUserDefaults()->Player{
        // Read/Get Data
        if let data = UserDefaults.standard.data(forKey: "player") {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()

                // Decode Note
                let player = try decoder.decode(self, from: data)
                
                return player
                
            } catch {
                print("Unable to Decode Note (\(error))")
            }
        }
        return Player()
    }
    
}

