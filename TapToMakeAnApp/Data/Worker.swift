//
//  Worker.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 11/01/22.
//

import Foundation

public struct Worker: Codable{
    
    let id: Int
    let isActive: Bool
    
    var name: String
    var basePower: Int
    var level: Int
    var rarety: Int
    var workerType: [String?] = [nil,nil]
    
    var power : Int {
        let player = Player.shared
        var power = basePower
        for wt in workerType {
            if wt != nil{
                switch EnumWorkweType3(rawValue: wt!){
                case .Coder:
                    guard let up = player.findUpgradeByName(name: "mechanical keyboard") else { return 0 }
                    power += up.level*10
                case .Designer:
                    guard let up = player.findUpgradeByName(name: "Drawing tablets") else { return 0 }
                    power += up.level*8
                case .Host:
                    guard let up = player.findUpgradeByName(name: "microfone") else { return 0 }
                    power += up.level*20
                default:
                    break
                }
            }
        }
        return power
    }
    
    static var library: [Worker] {
        return load("worker.json")
    }
    
}
