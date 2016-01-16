//
//  SectionTableViewController.swift
//  GroupMeTest
//
//  Created by Cody Li on 1/15/16.
//  Copyright © 2016 Brian Lin. All rights reserved.
//

import Foundation

import UIKit
import Alamofire
import Parse
import Bolts

class SectionTableViewController: UITableViewController {
    
    var subject: NSDictionary!
    var courses: NSArray!
    //    var delegate: GroupSelectTableViewControllerDelegate!
    //    var selectedCourse: [String: String]
    //    var filteredCourses: NSArray!
    //    var searchController: UISearchController!
    var parseClassString: String! = "Test2"
    var sectionNumArray = [String]()
//    var sectionNumArray = ["3","2"]
    var selectedSection: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        if let subjectCode = subject["code"] as? String {
        //            self.navigationItem.title? = subjectCode
        //        }
        
        Parse.setApplicationId("jy4MUG3yk2hLkU7NVTRRwQx1p5siV9BPwjr3410A",
            clientKey: "crnLPudofSLV9LmmydyAl2Eb8sJmlHi4Pd6HNtxW")
        
        
        // This code is for pulling stuff FROM PARSE
        // CITE: Taken from Parse's iOS Developers Guide: https://parse.com/docs/ios/guide#queries
        print("Receiving query from Parse")
        var query = PFQuery(className:parseClassString)
        //      query.whereKey("memberCount", lessThan: 7) // Max size pre add is 7 including Admin account
        //      query.whereKey("sectionNumber", equalTo: mySection) //Checks for group matching desired section number
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) open groups.")
                if objects!.count > 0 {
                    
                    // Do something with the found objects
                    if let objects = objects {
                        for object in objects {
                            if !self.sectionNumArray.contains(String(object["sectionNumber"]!)){
                                self.sectionNumArray.append(String(object["sectionNumber"]!))
                                print("Object ID: " + object.objectId!)
                                print("Group ID: " + String(object["groupID"]))
                                print("Share Token: " + String(object["shareToken"]))
                                print("Member Count: " + String(object["memberCount"]))
                                print("Section Number: " + String(object["sectionNumber"]))
                                print("Section Professor: " + String(object["sectionProf"]))
                                
                            }
                        }
                        print(self.sectionNumArray)
                        self.tableView.reloadData()
                    }
                }
            }
        }
        
        self.definesPresentationContext = true;
//        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        print("num sections")
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("num of rows")
        return self.sectionNumArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("populating table")
//        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        
        
        if let sectionNum = self.sectionNumArray[indexPath.row] as? String {
            cell.textLabel?.text = String(self.parseClassString + " " + sectionNum)
            cell.detailTextLabel?.text = sectionNum
        }
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        /* Retrieve course and append subject code and name */
        if let sectionNum = self.sectionNumArray[indexPath.row] as? String {
            self.selectedSection = sectionNum
            print(self.selectedSection)
            self.performSegueWithIdentifier("subjectToCourseSegue", sender: self)
        }
    }

    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "subjectToCourseSegue" {
            let joinVC = segue.destinationViewController as! ViewController
            //            courseVC.delegate = self.delegate
            //            sectionVC.subject = self.selectedCourse
            //            sectionVC.courses = self.courses
        }
    }
}
