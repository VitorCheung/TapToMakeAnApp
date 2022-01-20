//
//  WorkersEnum.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 11/01/22.
//

import Foundation

enum WorkersEnum: CaseIterable{

    static var Ju = Worker(name: "Ju", power: 1, level: 1, rarety: 4, workerType: [WorkersTypeEnum.Designer,nil])
    static var Muza = Worker(name: "Muza", power: 1, level: 1, rarety: 4, workerType: [WorkersTypeEnum.Host,nil])
    static var Marcus = Worker(name: "Marcus", power: 1, level: 1, rarety: 4, workerType: [WorkersTypeEnum.Coder,nil])
    static var Debs = Worker(name: "Debs", power: 1, level: 1, rarety: 4, workerType: [WorkersTypeEnum.Designer,nil])
    static var Talita = Worker(name: "Talita", power: 1, level: 1, rarety: 4, workerType: [WorkersTypeEnum.Host,nil])
    static var Fran = Worker(name: "Fran", power: 1, level: 1, rarety: 4, workerType: [WorkersTypeEnum.Coder,nil])
    static var Thallis = Worker(name: "Thallis", power: 1, level: 1, rarety: 4, workerType: [WorkersTypeEnum.Host,nil])
    static var Nath = Worker(name: "Nath", power: 1, level: 1, rarety: 4, workerType: [WorkersTypeEnum.Coder,nil])
    static var GK = Worker(name: "GK", power: 1, level: 1, rarety: 4, workerType: [WorkersTypeEnum.Coder,nil])
    static var Mari = Worker(name: "Mari", power: 1, level: 1, rarety: 4, workerType: [WorkersTypeEnum.Designer,nil])
    static var Fe = Worker(name: "Felipe", power: 1, level: 1, rarety: 4, workerType: [WorkersTypeEnum.Coder,nil])
    static var Rebecca = Worker(name: "Rebecca", power: 1, level: 1, rarety: 4, workerType: [WorkersTypeEnum.Coder,nil])
    static var Paulinha = Worker(name: "Paula", power: 6, level: 1, rarety: 5, workerType: [WorkersTypeEnum.Coder,nil])
    static var Taus = Worker(name: "Taus", power: 1, level: 1, rarety: 4, workerType: [WorkersTypeEnum.Coder,nil])
    static var Oliver = Worker(name: "Oliver", power: 1, level: 1, rarety: 4, workerType: [WorkersTypeEnum.Coder,nil])
    static var Triz = Worker(name: "Triz", power: 1, level: 1, rarety: 4, workerType: [WorkersTypeEnum.Coder,nil])
    static var Ortega = Worker(name: "Ortega", power: 1, level: 1, rarety: 4, workerType: [WorkersTypeEnum.Coder,nil])
    static var Basile = Worker(name: "Basile", power: 4, level: 1, rarety: 5, workerType: [WorkersTypeEnum.Coder,WorkersTypeEnum.Host])
    static var Cacique = Worker(name: "Cacique", power: 4, level: 1, rarety: 5, workerType: [WorkersTypeEnum.Coder,WorkersTypeEnum.Designer])
    static var Joaquim = Worker(name: "Joaquim", power: 6, level: 1, rarety: 5, workerType: [WorkersTypeEnum.Coder,nil])
    static var Japa = Worker(name: "Japa", power: 1, level: 1, rarety: 4, workerType: [WorkersTypeEnum.Coder,nil])
    static var Bii = Worker(name: "Bii", power: 1, level: 1, rarety: 4, workerType: [WorkersTypeEnum.Coder,nil])
    
    static let library = [
        WorkersEnum.Ju,
        WorkersEnum.Marcus,
        WorkersEnum.Muza,
        WorkersEnum.Debs,
        WorkersEnum.Talita,
        WorkersEnum.Fran,
        WorkersEnum.Thallis,
        WorkersEnum.Nath,
        WorkersEnum.GK,
        WorkersEnum.Mari,
        WorkersEnum.Fe,
        WorkersEnum.Rebecca,
        WorkersEnum.Paulinha,
        WorkersEnum.Taus,
        WorkersEnum.Oliver,
        WorkersEnum.Triz,
        WorkersEnum.Ortega,
        WorkersEnum.Cacique,
        WorkersEnum.Basile,
        WorkersEnum.Joaquim,
        WorkersEnum.Japa,
        WorkersEnum.Bii
    ]

}
