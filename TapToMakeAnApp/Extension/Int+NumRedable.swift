//
//  Int+NumRedable.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 27/01/22.
//

import Foundation
extension Int64{
    static func numRedable(num:Int64)->String{
        var count = 0
        var valor = num
        while(valor/1000>0){
            valor = valor/1000
            count += 1
        }
        switch count{
        case 1:
            return String("\(Float(num)/pow(Float(1000),Float(1)))K")
        case 2:
            return String("\(Float(num)/pow(Float(1000),Float(2)))M")
        case 3:
            return String("\(Float(num)/pow(Float(1000),Float(3)))B")
        case 4:
            return String("\(Float(num)/pow(Float(1000),Float(4)))T")
        case 5:
            return String("\(Float(num)/pow(Float(1000),Float(5)))Qua")
        case 6:
            return String("\(Float(num)/pow(Float(1000),Float(6)))Qui")
        default:
            return String(valor)
        }
        
    }
}
