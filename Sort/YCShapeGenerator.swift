//
//  YCShapeGenerator.swift
//  Sort
//
//  Created by yesh0907 on 3/17/15.
//  Copyright (c) 2015 Yesh Chandiramani. All rights reserved.
//

import UIKit
import SpriteKit

class YCShapeGenerator:SKSpriteNode {
    
    var shapes:YCShapes!
    var square:SKShapeNode!
    var circle:SKShapeNode!
    var triangle:SKShapeNode!
    var random:UInt32!
    var shapesArray = ["square", "triangle", "circle"]
    var shapesColorArray = [UIColor.redColor(), UIColor.blueColor(), UIColor.cyanColor(), UIColor.magentaColor(), UIColor.greenColor(), UIColor.whiteColor(), UIColor.yellowColor()]
    var shapeOnDisplay:NSString!
    var fadeTimer:NSTimeInterval = 3.2
    
    init(frame:CGSize) {
        super.init(texture: nil, color: UIColor.clearColor(), size: frame)
        shapes = YCShapes(frame: frame)
        genShape(shapesArray)
    }
    
    func genShape(n:NSArray) {
        let random = arc4random_uniform(UInt32(n.count))
        let fadeAway = SKAction.fadeAlphaTo(0, duration: fadeTimer)
        if (random == 0) {
            self.generateSquare()
            self.square.runAction(fadeAway)
            shapeOnDisplay = "square"
        }
        else if (random == 1) {
            self.generateCircle()
            self.circle.runAction(fadeAway)
            shapeOnDisplay = "circle"
        }
        else {
            self.generateTriangle()
            self.triangle.runAction(fadeAway)
            shapeOnDisplay = "triangle"
        }
    }
    
    func generateSquare() {
        let randomIndex = Int(arc4random_uniform(UInt32(shapesColorArray.count)))
        square = SKShapeNode(rectOfSize: CGSize(width: 60, height: 60))
        square.fillColor = shapesColorArray[randomIndex]
        square.strokeColor = .blackColor()
        square.position = CGPointMake(0, 0)
        square.lineWidth = 2.0
        addChild(square)
    }
    
    func generateCircle() {
        let randomIndex = Int(arc4random_uniform(UInt32(shapesColorArray.count)))
        circle = SKShapeNode(circleOfRadius: 35)
        circle.fillColor = shapesColorArray[randomIndex]
        circle.strokeColor = .blackColor()
        circle.lineWidth = 2.0
        circle.position = CGPointMake(0,0)
        addChild(circle)
    }
    
    func generateTriangle() {
        let randomIndex = Int(arc4random_uniform(UInt32(shapesColorArray.count)))
        let path: CGMutablePathRef = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, shapes.square.position.x + 0, shapes.square.position.y + 30)
        CGPathAddLineToPoint(path, nil, shapes.square.position.x - 40, shapes.square.position.y - 28)
        CGPathAddLineToPoint(path, nil, shapes.square.position.x + 45, shapes.square.position.y - 28)
        CGPathAddLineToPoint(path, nil, shapes.square.position.x + 0, shapes.square.position.y + 30)
        triangle = SKShapeNode(path: path)
        triangle.fillColor = shapesColorArray[randomIndex]
        triangle.strokeColor = .blackColor()
        triangle.lineWidth = 2.0
        addChild(triangle)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}