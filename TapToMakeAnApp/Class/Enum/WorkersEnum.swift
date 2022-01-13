//
//  WorkersEnum.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 11/01/22.
//

import Foundation

enum WorkersEnum: CaseIterable{

    static var Ju = Worker(name: "Ju", power: 1, rarety: 4)
    static var Muza = Worker(name: "Muza", power: 1, rarety: 4)
    static var Marcus = Worker(name: "Marcus", power: 1, rarety: 4)
    
    static let library = [
        WorkersEnum.Ju,
        WorkersEnum.Marcus,
        WorkersEnum.Muza
    ]

}
