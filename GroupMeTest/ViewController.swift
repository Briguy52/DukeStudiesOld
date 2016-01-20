//
//  ViewController.swift
//  GroupMeTest
//
//  Created by Brian Lin on 12/15/15.
//  Copyright © 2015 Brian Lin. All rights reserved.
//

// use: "let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate" to access the ACCESS_TOKEN variable of AppDelegate in other files like ViewController
var hasLoggedIn = false

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var largeButton: UIButton!
    @IBOutlet weak var viewButton: UIButton!

    @IBAction func largeButtonPress(sender: AnyObject) {
        
        // CITE: Taken from Sam Wilskey's tutorial: http://samwilskey.com/swift-oauth/
        let authURL = NSURL(string: "https://oauth.groupme.com/oauth/authorize?client_id=PbjA37nq8pWpjuHDALASadyhVccu3STL4Vj5DrjpZLooTwK6")
        UIApplication.sharedApplication().openURL(authURL!)
        
        // Skip Welcome page on subsequent logins
//        NSUserDefaults.standardUserDefaults().setObject(false, forKey: "hasLoggedIn")

    }
    @IBAction func viewButtonPressed(sender: AnyObject) {
//        self.performSegueWithIdentifier("startToDashSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewButton.hidden = true
        if let hasLoggedIn = NSUserDefaults.standardUserDefaults().objectForKey("hasLoggedIn") as? Bool {
            if hasLoggedIn {
                viewButton.hidden = false
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

