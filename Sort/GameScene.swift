//
//  GameScene.swift
//  Sort
//
//  Created by yesh0907 on 2/26/15.
//  Copyright (c) 2015 Yesh Chandiramani. All rights reserved.
//


/*
        IMPROVE DESIGN OVERALL, GO AS SIMPLE AS POSSIBLE
        ADD MORE SHARING FEATURES
*/


import SpriteKit
import UIKit
import AudioToolbox
import FBSDKCoreKit
import FBSDKShareKit

class GameScene: SKScene {
    
    var shapes:YCShapes!
    var game:YCGame!
    var shapeGenerator:YCShapeGenerator!
    
    var isStarted:Bool = false
    var isSwiped:Bool = false
    var gameOver:Bool = true
    var gameLabel:SKLabelNode!
    var startTitle:SKLabelNode!
    var restartTitle:SKLabelNode!
    var scoreLabel:SKLabelNode!
    var highScoreLabel:SKLabelNode!
    var sharingButton:SKLabelNode!
    var instructions:SKSpriteNode!
    var gameOverTitle:SKLabelNode!
    var container:SKSpriteNode!
    var playAgainButton:SKSpriteNode!
    var shareButton:SKSpriteNode!
    var gameOverHighscoreLabel:SKLabelNode!
    var gameOverScoreLabel:SKLabelNode!
    var height:CGFloat!
    var width:CGFloat!
    var highScore = NSUserDefaults.standardUserDefaults().integerForKey("highscore")
    var score = 0
    var fontName = "SF Wonder Comic"
    
    override func didMoveToView(view: SKView) {
        height = view.frame.height
        width = view.frame.width
        
        backgroundColor = UIColor(red: 159.0/255.0, green: 201.0/255.0, blue: 244.0/255.0, alpha: 1);
        createView()
    }
    
    func createSwipes() {
        //------------right  swipe gestures in view--------------//
        let swipeRight = UISwipeGestureRecognizer(target: self, action: Selector("rightSwiped"))
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        view?.addGestureRecognizer(swipeRight)
        
        //-----------left swipe gestures in view--------------//
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: Selector("leftSwiped"))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        view?.addGestureRecognizer(swipeLeft)
        
        //-----------down swipe gestures in view--------------//
        let swipeDown = UISwipeGestureRecognizer(target: self, action: Selector("downSwiped"))
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        view?.addGestureRecognizer(swipeDown)
    }
    
    func createView() {
        scoreLabel = SKLabelNode(text: "Score: \(score)")
        scoreLabel.position = CGPointMake((width/2 - scoreLabel.fontSize) + 30, height - 100)
        scoreLabel.fontSize = 50
        scoreLabel.fontName = "SF Wonder Comic"
        scoreLabel.fontColor = .whiteColor()
        
        highScoreLabel = SKLabelNode(text: "Best: \(highScore)")
        let hs = NSUserDefaults.standardUserDefaults().integerForKey("highscore")
        highScoreLabel = SKLabelNode(text: "Best: \(hs)")
        highScoreLabel.position = CGPointMake((width/2 - highScoreLabel.fontSize) + 30, height/2 - 150)
        highScoreLabel.fontSize = 50
        highScoreLabel.fontName = "SF Wonder Comic"
        highScoreLabel.fontColor = UIColor(red: 17/255, green:193/255, blue: 242/255, alpha: 1)
        
        shapes = YCShapes(frame: CGSizeMake(width, height))
        shapes.position = CGPointMake(width/2, height/2)
        addChild(shapes)
        
        game = YCGame(frame: CGSizeMake(width, height))
        game.position = shapes.position
        
        shapeGenerator = YCShapeGenerator(frame: CGSize(width: width, height: height))
        shapeGenerator.position = CGPointMake(width/2, height/2)
        
        gameOver = false
        switchScreenAnimation()
    }
    
    override func update(currentTime: NSTimeInterval) {
        if (isStarted && !gameOver) {
            if (!isSwiped) {
                if (shapeGenerator.shapeOnDisplay == "square") {
                    if (shapeGenerator.square.alpha == 0) {
                        gameOverAction()
                    }
                    else {
                        return
                    }
                }
                else if (shapeGenerator.shapeOnDisplay == "circle") {
                    if (shapeGenerator.circle.alpha == 0) {
                        gameOverAction()
                    }
                    else {
                        return
                    }
                }
                else if (shapeGenerator.shapeOnDisplay == "triangle") {
                    if (shapeGenerator.triangle.alpha == 0) {
                        gameOverAction()
                    }
                    else {
                        return
                    }
                }
            }
        }
        if (isStarted && gameOver) {
            if (shapeGenerator.shapeOnDisplay == "square") {
                shapeGenerator.square.removeAllActions()
            }
            if (shapeGenerator.shapeOnDisplay == "circle") {
                shapeGenerator.circle.removeAllActions()
            }
            if (shapeGenerator.shapeOnDisplay == "triangle") {
                shapeGenerator.triangle.removeAllActions()
            }
            shapes.removeAllActions()
            game.removeAllActions()
        }
    }
    
    func downSwiped() {
        if (isStarted && !gameOver) {
            isSwiped = true
            if (shapeGenerator.shapeOnDisplay == "square") {
                shapeGenerator.square.removeAllActions()
                let moveSquare = SKAction.moveToY(shapeGenerator.square.position.y - 170, duration: 0.6)
                let removeSquare = SKAction.fadeOutWithDuration(0.8)
                let remove = SKAction.removeFromParent()
                let action = SKAction.sequence([moveSquare, removeSquare, remove])
                shapeGenerator.square.runAction(action, completion: { () -> Void in
                    self.isSwiped = false
                })
                updateScore()
                newShape()
            }
            else {
                gameOverAction()
            }
        }
    }
    
    func rightSwiped() {
        if (isStarted && !gameOver) {
            isSwiped = true
            if (shapeGenerator.shapeOnDisplay == "triangle") {
                shapeGenerator.triangle.removeAllActions()
                let move = SKAction.moveToX(shapeGenerator.triangle.position.x + 100, duration: 0.6)
                let fade = SKAction.fadeOutWithDuration(0.8)
                let remove = SKAction.removeFromParent()
                let action = SKAction.sequence([move, fade, remove])
                shapeGenerator.triangle.runAction(action, completion: { () -> Void in
                    self.isSwiped = false
                })
                updateScore()
                newShape()
            }
            else {
                gameOverAction()
            }
        }
    }
    
    func leftSwiped() {
        if (isStarted && !gameOver) {
            isSwiped = true
            if (shapeGenerator.shapeOnDisplay == "circle") {
                shapeGenerator.circle.removeAllActions()
                let move = SKAction.moveToX(game.circle.position.x, duration: 0.6)
                let remove = SKAction.fadeOutWithDuration(0.8)
                let removeAction = SKAction.removeFromParent()
                let action = SKAction.sequence([move, remove, removeAction])
                shapeGenerator.circle.runAction(action, completion: { () -> Void in
                    self.isSwiped = false
                })
                updateScore()
                newShape()
            }
            else {
                gameOverAction()
            }
        }
    }
    
    func switchScreenAnimation() {
        self.highScoreLabel.fontSize = 30
        let hs = NSUserDefaults.standardUserDefaults().integerForKey("highscore")
        self.highScoreLabel.text = "Best: \(hs)"
        self.highScoreLabel.position = CGPointMake((self.width/2 - self.highScoreLabel.fontSize) + 30, self.height - 130)
        self.highScoreLabel.alpha = 1.0
        self.addChild(self.scoreLabel)
        self.addChild(self.shapeGenerator)
        
        self.isStarted = true
        self.createSwipes()
        addChild(game)
    }
    
    func newShape() {
        shapeGenerator.genShape(shapeGenerator.shapesArray)
    }
    
    func updateScore() {
        score += 1
        scoreLabel.removeFromParent()
        scoreLabel.text = "Score: \(score)"
        addChild(scoreLabel)
        
        if (score > NSUserDefaults.standardUserDefaults().integerForKey("highscore")) {
            NSUserDefaults.standardUserDefaults().setInteger(score, forKey: "highscore")
            NSUserDefaults.standardUserDefaults().synchronize()
            let hs = NSUserDefaults.standardUserDefaults().integerForKey("highscore")
            highScoreLabel.removeFromParent()
            highScoreLabel.text = "Best: \(hs)"
            addChild(highScoreLabel)
        }
        
        //DIFFCULTY
        if (score >= 0 && score <= 30) {
            shapeGenerator.fadeTimer = 2
        }
        else if (score >= 31 && score <= 60) {
            shapeGenerator.fadeTimer = 1.9
        }
        else if (score >= 61 && score <= 90) {
            shapeGenerator.fadeTimer = 1.7
        }
        else if (score >= 91 && score <= 120) {
            shapeGenerator.fadeTimer = 1.5
        }
        else if (score >= 121 && score <= 200) {
            shapeGenerator.fadeTimer = 1.4
        }
        else if (score >= 201 && score <= 300) {
            shapeGenerator.fadeTimer = 1.3
        }
        else if (score >= 301 && score <= 400) {
            shapeGenerator.fadeTimer = 1.1
        }
        else if (score >= 401 && score <= 500) {
            shapeGenerator.fadeTimer = 1.0
        }
        else if (score >= 501) {
            shapeGenerator.fadeTimer = 0.8
        }
        
        let correctSound = SKAction.playSoundFileNamed("correct.wav", waitForCompletion: false)
        runAction(correctSound)
    }
    
    func gameOverAction() {
        let gameOverSound = SKAction.playSoundFileNamed("wrong.wav", waitForCompletion: false)
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        runAction(gameOverSound, completion: { () -> Void in
            self.gameOver = true
            self.updateHighScore()
            self.makeGameOverScene()
        })
    }
    
    func makeGameOverScene() {
        removeAllActions()
        game.removeFromParent()
        shapes.removeFromParent()
        shapeGenerator.removeFromParent()
        let hs = NSUserDefaults.standardUserDefaults().integerForKey("highscore")
        
        //Set up
        gameOverTitle = SKLabelNode(text: "Game Over")
        gameOverTitle.fontName = fontName
        gameOverTitle.fontSize = 54
        gameOverTitle.fontColor = UIColor.init(red: 69/255, green: 153/255, blue: 249/255, alpha: 1.0)
        gameOverTitle.position = CGPoint(x: CGRectGetMidX(self.frame), y: height)
        
        container = SKSpriteNode(imageNamed: "GameOverContainer.png")
        container.position = CGPoint(x: CGRectGetMidX(self.frame), y: -15)
        
        playAgainButton = SKSpriteNode(imageNamed: "PlayButton.png")
        playAgainButton.position = CGPoint(x: CGRectGetMidX(self.frame) - playAgainButton.frame.size.width + 10, y: -20)
        playAgainButton.name = "playAgainButton"
        
        shareButton = SKSpriteNode(imageNamed: "ShareButton.png")
        shareButton.position = CGPoint(x: CGRectGetMidX(self.frame) + playAgainButton.frame.size.width - 10, y: -20)
        shareButton.name = "shareButton"
        
        gameOverScoreLabel = SKLabelNode(text: "\(score)")
        gameOverScoreLabel.fontName = fontName
        gameOverScoreLabel.fontSize = 54
        gameOverScoreLabel.fontColor = UIColor(red: 0/255, green: 133/255, blue: 255/255, alpha: 1.0)
        gameOverScoreLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 31)
        
        gameOverHighscoreLabel = SKLabelNode(text: "\(hs)")
        gameOverHighscoreLabel.fontName = fontName
        gameOverHighscoreLabel.fontSize = 54
        gameOverHighscoreLabel.fontColor = UIColor(red: 0/255, green: 133/255, blue: 255/255, alpha: 1.0)
        gameOverHighscoreLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 69)
        
        //Animations
        let fadeAway = SKAction.fadeOutWithDuration(0.3)
        let fadeIn = SKAction.fadeInWithDuration(0.4)
        let gameOverMoveDown = SKAction.moveToY(height - 85, duration: 0.5)
        let containerMoveUp = SKAction.moveToY(CGRectGetMidY(self.frame) + 15, duration: 0.5)
        let buttonsMoveUp = SKAction.moveToY(CGRectGetMidY(self.frame) - container.frame.size.height/2 + 40, duration: 0.5)
        scoreLabel.runAction(fadeAway) { () -> Void in
            self.highScoreLabel.runAction(fadeAway)
            self.addChild(self.gameOverTitle)
            self.addChild(self.container)
        }
        gameOverTitle.runAction(gameOverMoveDown)
        container.runAction(containerMoveUp) { () -> Void in
            self.addChild(self.playAgainButton)
            self.addChild(self.shareButton)
            self.playAgainButton.runAction(buttonsMoveUp)
            self.shareButton.runAction(buttonsMoveUp)
            self.addChild(self.gameOverScoreLabel)
            self.addChild(self.gameOverHighscoreLabel)
            self.gameOverScoreLabel.runAction(fadeIn)
            self.gameOverHighscoreLabel.runAction(fadeIn)
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if (gameOver && isStarted) {
            let touch = touches
            let location = touch.first!.locationInNode(self)
            let node = self.nodeAtPoint(location)
            
            if (node.name == "playAgainButton") {
                removeAllActions()
                let fadeOut = SKAction.fadeOutWithDuration(0.8)
                gameOverTitle.runAction(fadeOut) { () -> Void in
                  self.gameOverTitle.removeFromParent()
                }
                container.runAction(fadeOut) { () -> Void in
                    self.container.removeFromParent()
                }
                gameOverHighscoreLabel.runAction(fadeOut) { () -> Void in
                    self.gameOverHighscoreLabel.removeFromParent()
                }
                gameOverScoreLabel.runAction(fadeOut) { () -> Void in
                    self.gameOverScoreLabel.removeFromParent()
                }
                playAgainButton.runAction(fadeOut) { () -> Void in
                    self.playAgainButton.removeFromParent()
                }
                shareButton.runAction(fadeOut) { () -> Void in
                    self.shareButton.removeFromParent()
                    self.reset()
                }
            }
            else if (node.name == "shareButton") {
                let image = self.view?.pb_takeSnapshot()
                let photo:FBSDKSharePhoto = FBSDKSharePhoto()
                photo.image = image
                
                let content = FBSDKSharePhotoContent()
                content.contentURL = NSURL(string: "https://appsto.re/us/RdlL6.i")
                content.photos = [photo]
                
                let fbshare = FBSDKShareDialog()
                fbshare.shareContent = content
                fbshare.show()
            }
        }
    }
    
    func reset() {
        gameOver = false
        isStarted = false
        isSwiped = false
        score = 0
        shapeGenerator.fadeTimer = 3.2
        createView()
    }
    
    func updateHighScore() {
        if (score > NSUserDefaults.standardUserDefaults().integerForKey("highscore")) {
            NSUserDefaults.standardUserDefaults().setInteger(score, forKey: "highscore")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        NSUserDefaults.standardUserDefaults().setInteger(score, forKey: "score")
    }
}