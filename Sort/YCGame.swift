//
//  YCGame.swift
//  Sort
//
//  Created by yesh0907 on 3/4/15.
//  Copyright (c) 2015 Yesh Chandiramani. All rights reserved.
//

import UIKit
import SpriteKit

class YCGame:SKSpriteNode {
    
    var squareOutline:SKShapeNode!
    var circle:SKShapeNode!
    var triangle:SKShapeNode!
    var shapes:YCShapes!
    
    init(frame:CGSize) {
        super.init(texture: nil, color: UIColor.clearColor(), size: frame)
        shapes = YCShapes(frame: frame)
        self.drawSquare()
        self.drawCircle()
        self.drawTriangle()
    }
    
    func drawSquare() {
        squareOutline = SKShapeNode(rect: CGRectMake(0, 0, 60, 60))
        squareOutline.strokeColor = UIColor.blackColor()
        squareOutline.fillColor = UIColor.clearColor()
        squareOutline.lineWidth = 2.0
        squareOutline.position.x = shapes.square.position.x - 30
        squareOutline.position.y = shapes.square.position.y - 200
        addChild(squareOutline)
    }
    
    func drawTriangle() {
        let path: CGMutablePathRef = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, shapes.square.position.x + 100, shapes.square.position.y + 30)
        CGPathAddLineToPoint(path, nil, shapes.square.position.x + 60, shapes.square.position.y - 28)
        CGPathAddLineToPoint(path, nil, shapes.square.position.x + 145, shapes.square.position.y - 28)
        CGPathAddLineToPoint(path, nil, shapes.square.position.x + 100, shapes.square.position.y + 30)
        triangle = SKShapeNode(path: path)
        triangle.strokeColor = .blackColor()
        triangle.fillColor = .clearColor()
        triangle.lineWidth = 2.0
        addChild(triangle)
    }
    
    func drawCircle() {
        circle = SKShapeNode(circleOfRadius: 35)
        circle.fillColor = .clearColor()
        circle.strokeColor = .blackColor()
        circle.lineWidth = 2.0
        circle.position = CGPointMake(shapes.square.position.x - 100, shapes.square.position.y)
        addChild(circle)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}