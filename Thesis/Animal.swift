//
//  Animal.swift
//  Thesis
//
//  Created by Kaya Thomas on 9/28/16.
//  Copyright © 2016 Kaya Thomas. All rights reserved.
//

import SpriteKit

class Animal : SKSpriteNode
{
    var kCategoryOne = UInt32(1 << 0)
    var kCategoryTwo = UInt32(1 << 1)
    var moveAnimation: SKAction = SKAction()
    
    init(imageNamed name: String)
    {
        let texture = SKTexture(imageNamed: name)
        
        
        let textures = [SKTexture(imageNamed:"monkey_right.png"), SKTexture(imageNamed:"monkey-left.png")]
        moveAnimation = SKAction.animate(with: textures, timePerFrame:0.3)
        
        super.init(texture: texture, color: UIColor.white, size: textures[1].size())
        
        physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2.0)
        physicsBody!.categoryBitMask = kCategoryOne
        physicsBody!.contactTestBitMask = kCategoryTwo
        physicsBody!.collisionBitMask = kCategoryTwo
        
        
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
    }
    
    func move(_ x: CGFloat, y: CGFloat){
        if(action(forKey: "moveAction") == nil) {
            run(moveAnimation, withKey:"moveAction")
        }
        self.position = CGPoint(x: x,y: y)
        
    }
}

