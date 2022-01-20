//
//  WorkerTypeEnem.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 18/01/22.
//

import Foundation

enum WorkersTypeEnum: CaseIterable{

    static var Coder = WorkerType(name: "coder", description: "If your team have 3\nprogramers, your\npawer will be double")
    static var Designer = WorkerType(name: "designer", description: "If your team have 3\ndesignerall, your\nteam gain 5 power")
    static var Host = WorkerType(name: "host", description: "If your team have 3\nHost, your deadline\nwill incrise 5 days")
    
    static var library = [
        WorkersTypeEnum.Coder,
        WorkersTypeEnum.Designer,
        WorkersTypeEnum.Host,
    ]
}
