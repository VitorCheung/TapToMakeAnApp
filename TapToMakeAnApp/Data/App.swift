//
//  App.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 13/01/22.
//

import Foundation

public struct App: Codable{
    let points: Int
    var money: Int64 {
        var multiplier:Int64 = Int64(points/20)
        var i = 1
        while points/(25*i)>1{
            i += 1
            multiplier += Int64(points/20)
     }
        if Player.shared.upgrades[3].level != 0 {
            return 2+Int64(Double(multiplier)*3*Double(Player.shared.upgrades[3].level))
        }
        return 2+(2*multiplier)
        
    }
    var earning: Int64{
        var multiplier = Int64(points/100)
        var i = 1
        if multiplier != 0 {
            while points/(100*i)>1{
                i += 1
                multiplier += Int64(points/90)
            }
        }
        
        if Player.shared.upgrades[2].level != 0 {
            return 1+Int64(Double(multiplier)*1.25*Double(Player.shared.upgrades[2].level))
        }
        
        return 1+multiplier
    }
}
