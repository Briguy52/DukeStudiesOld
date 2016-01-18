//
//  GroupTableViewController.swift
//
//
//  Created by Cody Li on 1/16/16.
//
//

import Foundation
import UIKit
import Alamofire
import Parse
import Bolts

class GroupTableViewController: UITableViewController{
    
    //Test material
    var classObjectMap:[String: String] = ["AAAS89S": "QOby6lGz9d", "MATH212": "FqG4iWZKAh"]
    
    var classNameArray = [String]()
    //    var sectionNumberArray = [String]()
    var profNameArray = [String]()
    var groupMeIDArray =  [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
        
        // This code is for setting up PARSE
        Parse.setApplicationId("jy4MUG3yk2hLkU7NVTRRwQx1p5siV9BPwjr3410A",
            clientKey: "crnLPudofSLV9LmmydyAl2Eb8sJmlHi4Pd6HNtxW")
        
        
        // This code is for pulling stuff FROM PARSE
        // CITE: Taken from Parse's iOS Developers Guide: https://parse.com/docs/ios/guide#queries
        //        print("Receiving query from Parse")
        //        let query = PFQuery(className:parseClassString)
        //        print(classObjectMap["AAAS89S"])
        for (courseName, objID) in classObjectMap{
            
            let query = PFQuery(className: courseName)
            self.classNameArray.append(courseName)
            query.findObjectsInBackgroundWithBlock {
                (objects: [PFObject]?, error: NSError?) -> Void in
                if error == nil {
                    // The find succeeded.
                    // print("Successfully retrieved \(objects!.count) open groups.")
                    if objects!.count > 0 {
                        
                        // Do something with the found objects
                        if let objects = objects {
                            for object in objects {
                                if objID == object.objectId {
                                    //                                    self.sectionNumberArray.append(String(object["sectionNumber"]!))
                                    
                                    //                                    print(String(object["sectionNumber"]))
                                    self.profNameArray.append(String(object["sectionProf"]!))
                                    //                                    print(String(object["sectionProf"]))
                                    self.groupMeIDArray.append(String(object["groupID"]!))
                                    //                                    print(String(object["groupID"]))
                                }
                            }
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }
        
        //        self.definesPresentationContext = true;
        self.tableView.reloadData()
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
        
        print(classNameArray.count)
        print(profNameArray.count)
        print(groupMeIDArray.count)
        if let groupName = self.classNameArray[indexPath.row] as? String {
            cell.textLabel?.text = String(groupName)
        }
        
        if let sectionProf = self.profNameArray[indexPath.row] as? String {
            cell.detailTextLabel?.text = String(sectionProf)
        }
        return cell
    }
    
    // MARK: - Table view delegate
    
    //When you actually pick a group
    //    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    //        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    //
    //            /* Retrieve course and append subject code and name */
    //        
    //                
    //            self.performSegueWithIdentifier("courseToSectionSegue", sender: self)
    //        }
    //    }
}


