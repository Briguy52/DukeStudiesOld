//
//  SectionTableViewController.swift
//  GroupMeTest
//
//  Created by Cody Li on 1/15/16.
//  Copyright © 2016 Brian Lin. All rights reserved.
//

// Note: Backend 'JOIN' calls are made in this VC

import Foundation

import UIKit
import Alamofire
import Parse
import Bolts

class SectionTableViewController: UITableViewController {
    
    
    var parseClassString: String!
    var subject: NSDictionary!
    var courses: NSArray!
    var selectedSubjectString: String!
    var selectedCourseString: String!

    var sectionNumArray = [String]() // array of existing course numbers
    var sectionProfArray = [String]() // array of professor names, corresponds to sectionNumArray
    var groupIDArray = [String]() // array of groupIDs
    var shareTokenArray = [String]() // array of shareTokens
    var objectIDArray = [String]() // array of objectIDs
    var selectedSection: String! // section selected by user
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
        
        // Init Parse
        Parse.setApplicationId("jy4MUG3yk2hLkU7NVTRRwQx1p5siV9BPwjr3410A",
            clientKey: "crnLPudofSLV9LmmydyAl2Eb8sJmlHi4Pd6HNtxW")
        
        
        // This code is for pulling stuff FROM PARSE
        // CITE: Taken from Parse's iOS Developers Guide: https://parse.com/docs/ios/guide#queries
        let query = PFQuery(className:parseClassString)
        query.whereKey("memberCount", lessThan: 7) // Max size pre add is 7 including Admin account
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                // The find succeeded.
                if objects!.count > 0 {
                    
                    // Do something with the found objects
                    if let objects = objects {
                        for object in objects {
                                self.objectIDArray.append(object.objectId!)
                                self.sectionNumArray.append(String(object["sectionNumber"]!))
                                self.sectionProfArray.append(String(object["sectionProf"]!))
                                self.groupIDArray.append(String(object["groupID"]!))
                                self.shareTokenArray.append(String(object["shareToken"]!))
                        }
                        self.tableView.reloadData()
                    }
                }
            }
        }
        
        self.definesPresentationContext = true;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        self.performSegueWithIdentifier("sectionToCourseCancel", sender: self)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sectionNumArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Note: UITableViewCellStyle.Default DOES NOT allow for subtitles!
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        
        // Display Class + Course + Section
        if let sectionNum = self.sectionNumArray[indexPath.row] as? String {
            cell.textLabel?.text = String(self.selectedSubjectString + " " + self.selectedCourseString + " " + "Section: " + sectionNum)
        }
        
        // Display Subtitle
        if let sectionProf = self.sectionProfArray[indexPath.row] as? String {
            cell.detailTextLabel?.text = String(sectionProf)
        }
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        /* Retrieve course and append subject code and name */
        if let sectionNum = self.sectionNumArray[indexPath.row] as? String {
            self.selectedSection = sectionNum
            // Make backend call for JOIN
            let myBackend = Backend()
            myBackend.makeString(self.groupIDArray[indexPath.row], shareToken: self.shareTokenArray[indexPath.row], objID: self.objectIDArray[indexPath.row], token: myBackend.ACCESS_TOKEN, courseString: self.parseClassString)
            self.performSegueWithIdentifier("sectionToDashSegue", sender: self)
        }
    }

    
    // MARK: - Navigation
    
    // Should add user to selected group (ie call backend)
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "sectionToDashSegue" {
            let dashVC = segue.destinationViewController as! DashboardTableViewController
        }
        if segue.identifier == "createGroupSegue" {
            let createVC = segue.destinationViewController as! CreateGroupViewController
            createVC.parseClassString = self.parseClassString
            createVC.subject = self.subject
            createVC.courses = self.courses
            createVC.selectedCourseString = self.selectedCourseString
            createVC.selectedSubjectString = self.selectedSubjectString

        }
        if segue.identifier == "sectionToCourseCancel" {
            let courseVC = segue.destinationViewController as! CourseTableViewController
            courseVC.parseClassString = self.selectedSubjectString
            courseVC.subject = self.subject
            courseVC.courses = self.courses
            courseVC.selectedSubjectString = self.selectedSubjectString
        }
    }
}
