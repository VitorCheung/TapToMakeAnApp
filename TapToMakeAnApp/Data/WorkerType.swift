//
//  Type.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 18/01/22.
//

import Foundation

public struct WorkerType: Codable{
    let name: String
    let description: String
    
    static var library: [WorkerType] {
        return load("workerType.json")
    }
    
    static func getDescription(name:String)->String{
        for wt in WorkerType.library {
            if name == wt.name {
                return wt.description
            }
        }
            return ""
    }
    
}
