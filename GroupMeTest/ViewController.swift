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
    @IBAction func largeButtonPress(sender: AnyObject) {
        
        // CITE: Taken from Sam Wilskey's tutorial: http://samwilskey.com/swift-oauth/
        let authURL = NSURL(string: "https://oauth.groupme.com/oauth/authorize?client_id=PbjA37nq8pWpjuHDALASadyhVccu3STL4Vj5DrjpZLooTwK6")
        UIApplication.sharedApplication().openURL(authURL!)
        
        if hasLoggedIn {
            self.performSegueWithIdentifier("startToDashSegue", sender: self)
        }
    }

//        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate // From StackOverflow: http://stackoverflow.com/questions/24046164/how-do-i-get-a-reference-to-the-app-delegate-in-swift
//        appDelegate.testFunc("Button Pressed")


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "startToDashSegue" {
            let dashVC = segue.destinationViewController as! DashboardTableViewController
        }
    }


}

