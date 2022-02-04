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
        var multiplier:Int64 = Int64(points/25)
        var i = 1
        while points/(10*i)>1{
            i += 1
            multiplier += Int64(points/25)
        }
        if Player.shared.bonus2(workerType: EnumWorkweType3.CatLovers.rawValue){
            return (2+multiplier)*4
        }
        else{
            return 2+multiplier
        }
    }
    
    var earning: Int64{
        var multiplier = Int64(points/200)
        var i = 1
        if multiplier != 0 {
            while points/(200*i)>1{
                i += 1
                multiplier += Int64(points/180)
            }
        }
        return 1+Int64(multiplier)
    }
}
