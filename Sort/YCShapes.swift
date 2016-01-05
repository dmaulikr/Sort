//
//  YCShapes.swift
//  Sort
//
//  Created by yesh0907 on 2/26/15.
//  Copyright (c) 2015 Yesh Chandiramani. All rights reserved.
//

import Foundation
import SpriteKit

class YCShapes:SKSpriteNode {
    var circle:SKShapeNode!
    var triangle: SKShapeNode!
    var square: SKSpriteNode!
    
    init(frame: CGSize) {
        super.init(texture: nil, color: UIColor.clearColor(), size: frame)
        self.drawSquare()
        self.drawCircle()
        self.drawTriangle()
    }
    
    func drawSquare() {
        square = SKSpriteNode(texture: nil, color: UIColor.blueColor(), size: CGSize(width: 60, height: 60))
        //addChild(square)
    }
    
    func drawCircle() {
        circle = SKShapeNode(circleOfRadius: 35)
        circle.fillColor = .redColor()
        circle.strokeColor = .blackColor()
        circle.lineWidth = 2.0
        circle.position = CGPointMake(square.position.x - 100, square.position.y)
        //addChild(circle)
    }
    
    func drawTriangle() {
        let path: CGMutablePathRef = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, square.position.x + 100, square.position.y + 30)
        CGPathAddLineToPoint(path, nil, square.position.x + 60, square.position.y - 28)
        CGPathAddLineToPoint(path, nil, square.position.x + 145, square.position.y - 28)
        CGPathAddLineToPoint(path, nil, square.position.x + 100, square.position.y + 30)
        triangle = SKShapeNode(path: path)
        triangle.strokeColor = .yellowColor()
        triangle.fillColor = .greenColor()
        triangle.lineWidth = 2.0
        //addChild(triangle)
    }
      
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}