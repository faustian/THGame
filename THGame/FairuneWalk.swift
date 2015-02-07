//
//  FairuneWalk.swift
//  THGame
//
//  Created by Kimberly Lister on 2/7/15.
//  Copyright (c) 2015 Kimberly Lister. All rights reserved.
//

import Foundation
import SpriteKit

class FairuneWalk : SKSpriteNode {
    //Fairune walking sprite
    override init() {
        //strip with all walk sprites
        let walkSpriteTexture = SKTexture(imageNamed:"Fairune_sprite.png")
        let faceDown1 = SKTexture(rect:CGRectMake(0.0,0.0,(1.0/9.0),1.0), inTexture:walkSpriteTexture)
        let faceDown2 = SKTexture(rect:CGRectMake((1.0/9.0),0.0,(2.0/9.0),1.0), inTexture:walkSpriteTexture)
        let faceUp1 = SKTexture(rect:CGRectMake((2.0/9.0),0.0,(3.0/9.0),1.0), inTexture:walkSpriteTexture)
        let faceUp2 = SKTexture(rect:CGRectMake((3.0/9.0),0.0,(4.0/9.0),1.0), inTexture:walkSpriteTexture)
        let faceLeft1 = SKTexture(rect:CGRectMake((4.0/9.0),0.0,(5.0/9.0),1.0), inTexture:walkSpriteTexture)
        let faceLeft2 = SKTexture(rect:CGRectMake((5.0/9.0),0.0,(6.0/9.0),1.0), inTexture:walkSpriteTexture)
        let faceRight1 = SKTexture(image:UIImage.imageWithCIImage(CIImage.imageByApplyingTransform(nil)))
        faceLeft1.xScale(-1.0)
        super.init(texture:faceDown1, color:nil, size:faceDown1.size())
        
        let stepDown = SKAction.animateWithTextures([faceDown1, faceDown2], timePerFrame:0.06)
        let step
    }
    
    //subclasses of SKSpriteNode need this
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}