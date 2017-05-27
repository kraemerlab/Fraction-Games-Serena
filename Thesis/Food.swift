//
//  Food.swift
//  Thesis
//
//  Created by Kaya Thomas on 9/28/16.
//  Copyright © 2016 Kaya Thomas. All rights reserved.
//

import SpriteKit

class Food : SKSpriteNode
{
    let imgName:String
    var kCategoryOne = UInt32(1 << 0)
    var kCategoryTwo = UInt32(1 << 1)
    
    init(imageNamed name: String)
    {
        self.imgName = name
        let texture = SKTexture(imageNamed: name)
        super.init(texture: texture, color: UIColor.white, size: texture.size())
        
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody!.categoryBitMask = kCategoryTwo
        physicsBody!.contactTestBitMask = kCategoryOne
        physicsBody!.collisionBitMask = kCategoryOne
        physicsBody!.isDynamic = false // if true then can move the bananas
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func mutableCopy() -> Any {
        return Food(imageNamed: self.imgName)
    }
    
}

