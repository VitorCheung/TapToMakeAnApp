//
//  App.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 13/01/22.
//

import Foundation

public struct App: Codable{
    let name: String
    let points: Int
    var money: Int {
        return points*5
    }
    var earning: Int{
        return 5
    }
}