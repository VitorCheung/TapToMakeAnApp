//
//  ColorPalete.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 10/01/22.
//

import UIKit

enum ColorPalette {
    static var mainGreen: UIColor {
        UIColor(named: "greenPc") ?? .green
    }
    static var backgroundGray: UIColor {
        UIColor(named: "grayPc") ?? .gray
    }
    
    static var goldWin: UIColor {
        UIColor(named: "goldWin") ?? .yellow
    }
}
