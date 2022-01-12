//
//  Code.swift
//  TapToMakeAnApp
//
//  Created by Vitor Cheung on 10/01/22.
//

import SpriteKit

public class CodeNode: SKSpriteNode{
    public init(width:Int){
        super.init(texture: nil, color: UIColor.clear, size: CGSize(width: width, height: 10))
        self.color = ColorPalette.mainGreen
        name="Code"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
