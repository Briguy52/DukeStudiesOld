//
//  DashboardTableViewController.swift
//
//
//  Created by Cody Li on 1/16/16.
//
//

// Note: No backend methods are called in this VC

import Foundation
import UIKit
import Alamofire
import Parse
import Bolts

class DashboardTableViewController: UITableViewController{

    
    // Arrays to fill from Parse query response
    var classNameArray = [String]() // to display as title
    var sectionNumberArray = [String]() // to display in title
    var profNameArray = [String]() // to display as description
    var groupIDArray =  [String]() // for deeplinking to GroupMe app
    var selectedGroup: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
        
        // This code is for setting up PARSE
        Parse.setApplicationId("jy4MUG3yk2hLkU7NVTRRwQx1p5siV9BPwjr3410A",
            clientKey: "crnLPudofSLV9LmmydyAl2Eb8sJmlHi4Pd6HNtxW")
        
        
        // This code is for pulling stuff FROM PARSE
        // CITE: Taken from Parse's iOS Developers Guide: https://parse.com/docs/ios/guide#queries
        if let classObjectMap = NSUserDefaults.standardUserDefaults().objectForKey("classObjectMap") as? NSDictionary {
            print(classObjectMap.allKeys)
            for (courseName, objID) in classObjectMap{
                
                let query = PFQuery(className: String(courseName))
                query.whereKey("objectId", equalTo: objID) // Checks for group matching desired section number
                query.findObjectsInBackgroundWithBlock {
                    (objects: [PFObject]?, error: NSError?) -> Void in
                    if error == nil {
                        // The find succeeded.
                        if objects!.count > 0 {
                            // Do something with the found objects
                            if let objects = objects {
                                for object in objects {
                                    //                                    print("Object ID: " + String(object.objectId!))
                                    //                                    print(String(object["sectionProf"]))
                                    self.classNameArray.append(String(courseName))
                                    self.sectionNumberArray.append(String(object["sectionNumber"]))
                                    self.profNameArray.append(String(object["sectionProf"]))
                                    self.groupIDArray.append(String(object["groupID"]))
                                }
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
        
        self.definesPresentationContext = true;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.classNameArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")

        if let groupName = self.classNameArray[indexPath.row] as? String {
            cell.textLabel?.text = String(groupName)
        }
        
        if let sectionProf = self.profNameArray[indexPath.row] as? String {
            cell.detailTextLabel?.text = String(sectionProf)
        }
        
        return cell
    }
    
    // MARK: - Table view delegate
    
        override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            
            // Open group in GroupMe app with: groupme://g/{group_id}
            if let groupID = self.groupIDArray[indexPath.row] as? String {
                let deepLink = NSURL(string: "groupme://g/" + groupID)
                UIApplication.sharedApplication().openURL(deepLink!) 
            }

        }
}


