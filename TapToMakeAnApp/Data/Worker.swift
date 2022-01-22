//
//  Worker.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 11/01/22.
//

import Foundation

public struct Worker: Codable{
    let name: String
    var power: Int
    var level: Int
    var rarety: Int
    var workerType: [String?] = [nil,nil]
    
    static var library: [Worker] {
        return load("worker.json")
    }
    
}
