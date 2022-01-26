//
//  Upgrade.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 20/01/22.
//

import Foundation

public struct Upgrade: Codable{
    
    let id: Int
    let isActive: Bool
    
    var name: String
    var scalePrice: Double
    var level = 0
    var description: String
    
    var price: Int64 {
        return Int64(scalePrice*pow(Double(level),Double(2))+scalePrice)
    }
    
    static var library: [Upgrade] {
        return load("upgrades.json")
    }
}
