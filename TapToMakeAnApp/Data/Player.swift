//
//  Player1.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 14/01/22.
//

import Foundation

class Player: Codable{
    
    //Singleton
    static var shared = Player()
    
    //Data
    var money : Int64 = 0
    var points : Int = 0
    var docsBuy = 0
    var workers : [Worker] = []
    var team : [Worker?] = [nil,nil,nil]
    var apps : [App?] = []
    var upgrades : [Upgrade] = Upgrade.library
    var deadLine : Int{
        var timeDeadLine = 10
        if bonus(workerType: WorkersTypeEnum.Host.rawValue){
            timeDeadLine += 15
        }
        return timeDeadLine+1*upgrades[1].level
    }
    
    //MARK: Functions
    
    func priceDocs()->Int64{
        return Int64(1041*pow(Double(docsBuy),Double(2))+100)
    }

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
                if bonus(workerType: WorkersTypeEnum.Designer.rawValue){
                    clickPower += (power+10)*(work?.level ?? 1)
                }else{
                    clickPower += power*(work?.level ?? 1)
                }
            }
        }
        
        if bonus(workerType: WorkersTypeEnum.Coder.rawValue){
            clickPower *= 2
        }
        return clickPower+1*upgrades[0].level
        
    }
    
    func bonus(workerType:String)->Bool{
        var worker = 0
        for members in team {
            if let m = members {
                for wt in m.workerType {
                    if wt == workerType{
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
    
    //MARK:Codable
    
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
    
    func verifyData(){
        
        for i in 0..<workers.count {
                for workerLibery in Worker.library {
                    if workers[i].name == workerLibery.name {
                        workers[i].power = workerLibery.power
                        workers[i].workerType = workerLibery.workerType
                    }
            }
        }
        
        for i in 0..<team.count {
                for workerLibery in Worker.library {
                    if team[i]?.name == workerLibery.name {
                        team[i]?.power = workerLibery.power
                        team[i]?.workerType = workerLibery.workerType
                    }
            }
        }
        
        for i in 0..<upgrades.count {
                for upgradeLibrary in Upgrade.library {
                    if upgrades[i].name == upgradeLibrary.name {
                        upgrades[i].description = upgradeLibrary.description
                        upgrades[i].scalePrice = upgradeLibrary.scalePrice
                    }
            }
        }
        
        
    }
}

