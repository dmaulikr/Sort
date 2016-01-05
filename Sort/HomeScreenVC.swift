//
//  HomeScreenVC.swift
//  Sort
//
//  Created by yesh0907 on 10/12/15.
//  Copyright © 2015 Yesh Chandiramani. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKShareKit

class HomeScreenVC: UIViewController {
    @IBOutlet weak var SortTitle: UILabel!
    @IBOutlet var HighScoreLabel: UILabel!
    
    @IBAction func Instructions(sender: AnyObject) {
    }
    
    @IBAction func PlayButtonPressed(sender: AnyObject) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc:GameViewController = storyboard.instantiateViewControllerWithIdentifier("GameViewController") as! GameViewController
        self.view?.window?.rootViewController?.presentViewController(vc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let hs = NSUserDefaults.standardUserDefaults().integerForKey("highscore")
        HighScoreLabel.text = "Best: \(hs)"
        
        let likeButton:FBSDKLikeControl = FBSDKLikeControl()
        likeButton.objectID = "https://www.facebook.com/sorttheshapeswipinggame/"
        likeButton.center = CGPointMake(self.view.center.x + likeButton.frame.size.width, self.view.frame.height - 30)
        self.view.addSubview(likeButton)
        
        let content:FBSDKShareLinkContent = FBSDKShareLinkContent()
        content.contentDescription = "Get the game now and challenge me to a sorting war..."
        content.contentURL = NSURL(string: "https://appsto.re/us/RdlL6.i")
        content.contentTitle = "Sort - the Shape Swiping Game!"
        
        let shareButton:FBSDKShareButton = FBSDKShareButton()
        shareButton.shareContent = content
        shareButton.center = CGPointMake(self.view.center.x - likeButton.frame.size.width, self.view.frame.height - 30)
        view.addSubview(shareButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
