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
        guard let up = findUpgradeByName(name: "Air Conditioner") else { return 0 }
            if bonus2(workerType: EnumWorkweType2.Musicians.rawValue){
                return 15+up.level
            }
        return 5+up.level
    }
    
    var serverSpace:Int{
        guard let up = findUpgradeByName(name: "Server") else { return 0 }
        return 2+up.level
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
        var debs: Bool = false
        var karina: Int = 0
        for work in team{
            if work?.name == "Debs"{
                debs = true
            }
            if work?.name == "Karina"{
                guard let l = work?.level else { return 0}
                karina = l
            }
        }
        
        for work in team{
            if let power = work?.power {
                
                var level: Int{
                    if karina > 0{
                        return (work?.level ?? 1) + karina
                    }
                    else{
                        return work?.level ?? 1
                    }
                }
                
                if bonus3(workerType: EnumWorkweType3.Designer.rawValue) || debs{
                    clickPower += (power+10)*(level)
                }
                if bonus3(workerType: EnumWorkweType2.Sinblings.rawValue){
                    clickPower += (power+10*apps.count)*(level)
                }else
                {
                    clickPower += power*(level)
                }
            }
        }
        
        if bonus2(workerType: EnumWorkweType2.Otaku.rawValue){
            clickPower += workers.count+team.filter({ $0 == nil }).count
        }
        
        if bonus3(workerType: EnumWorkweType3.Coder.rawValue){
            clickPower *= 2
        }

        return clickPower
        
    }
    
    func earningPoints()-> Int{
        guard let upPC = findUpgradeByName(name: "Upgrade PC") else { return 0 }
        guard let upCoffe = findUpgradeByName(name: "Coffe") else { return 0 }
        guard let upWifi = findUpgradeByName(name: "Wifi") else { return 0 }
        guard let upPhone = findUpgradeByName(name: "Phone") else { return 0 }
        guard let upTablet = findUpgradeByName(name: "Tablet") else { return 0 }
        
        let ep = upPC.level + upCoffe.level*(workers.count+team.filter({ $0 == nil }).count) + 5*upWifi.level*apps.count + 25*upPhone.level*countRaraty(rarety: 4) + 50*upTablet.level*countRaraty(rarety: 5)
        
        if bonus3(workerType: EnumWorkweType3.Host.rawValue){
            return ep*2
        }
        
        return ep
    }
    
    func countRaraty(rarety: Int)->Int{
        let allWorkers = workers+team
        var num = 0
        for worker in allWorkers {
            if let w = worker {
                if w.rarety == rarety{
                        num += 1
                }
            }
        }
        return num
    }
    
    func bonus2(workerType:String)->Bool{
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
        if worker == 2 {
            return true
        }
        else{
            return false
        }
    }
    
    func bonus3(workerType:String)->Bool{
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
    
    func findUpgradeByName(name: String)-> Upgrade?{
        for up in upgrades {
            if up.name == name{
                return up
            }
        }
        return nil
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
            if Worker.library[workers[i].id].isActive{
                workers[i].name = Worker.library[workers[i].id].name
                workers[i].basePower = Worker.library[workers[i].id].basePower
                workers[i].workerType = Worker.library[workers[i].id].workerType
            }
            else{
                workers.remove(at: i)
            }
        }
        
        for i in 0..<team.count {
            if var worker = team[i] {
                if Worker.library[worker.id].isActive{
                    worker.name = Worker.library[worker.id].name
                    worker.basePower = Worker.library[worker.id].basePower
                    worker.workerType = Worker.library[worker.id].workerType
                    team[i] = worker
                }
                else{
                    team[i] = nil
                }
            }

        }
        

        for i in 0..<Upgrade.library.count  {
            if Upgrade.library[i].isActive {
                if i<upgrades.count{
                    upgrades[i].name = Upgrade.library[i].name
                    upgrades[i].description = Upgrade.library[i].description
                    upgrades[i].scalePrice = Upgrade.library[i].scalePrice
                }
                else{
                    upgrades.append(Upgrade.library[i])
                }
                    
            }
            else{
                upgrades.remove(at: i)
            }

        }
        
        
    }
}

