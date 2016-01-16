//  BackEndMethods.swift
//  GroupMeTest
//
//  Created by Austin Hua on 1/15/16.
//  Copyright © 2016 Brian Lin. All rights reserved.
//

import UIKit
import Alamofire
import Parse
import Bolts




//TO STORE DATA LOCALLY
//      NSUserDefaults.standardUserDefaults().setObject("Rob", forKey: "name")
//
//TO ACCESS DATA STORED LOCALLY
//      if let userName = NSUserDefaults.standardUserDefaults().objectForKey("name") as? String {
//          print(userName)
//      }

// -------------------------------------------
//  BACKEND METHODS TO BE INTEGRATED WITH APP
// -------------------------------------------

class Backend {
    let baseURL = "https://api.groupme.com/v3"
    let ADMIN_TOKEN: String! = "Uy6V4BXpuvHDp6XUWZ0IkgSQojFRw1h3SRhAWoK6"
    var courseString = "Test1"
    var sectionNumber = "99"
    
    
    // Recheck member count in GroupMe through Alamofire call
    func getGroupMeMemberCount(groupID: String, objID: String) -> Void {
        var memberCount = Int()
        Alamofire.request(.GET, self.baseURL + "/groups/" + groupID + "?token=" + self.ADMIN_TOKEN) // SHOW group information
            .responseJSON { response in
                if let test = response.result.value {
                    // Find number of members
                    memberCount = test["response"]!!["members"]!!.count
                    // !!!!!!! PUT THE NEXT CODE/FUNCTION TO BE RUN HERE TO WAIT FOR ALAMOFIRE RESPONSE
                }
        }
        
    }
    
    // Get member count from Parse with some courseString(ClassName) and sectionNumber, gotten from the global variables,
    func getParseMemberCount(groupID: String, objID: String) -> Void { // Can extend to get other information from Parse
        var query = PFQuery(className:courseString)
        query.getObjectInBackgroundWithId(objID)
            {
            (object: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
                print("Error from Parse")
            } else if let object = object {
                var memberCount: Int = object["memberCount"] as! Int
                // !!!!!!! PUT THE NEXT CODE/FUNCTION TO BE RUN HERE TO WAIT FOR PARSE RESPONSE
            }
        }
//        query.findObjectsInBackgroundWithBlock {
//            (objects: [PFObject]?, error: NSError?) -> Void in
//            if error == nil {
//                // The find succeeded.
//                print("Successfully retrieved \(objects!.count) groups.")
//                // Do something with the found objects
//                if let objects = objects {
//                    for object in objects {
//                        print("Object ID: " + object.objectId!)
//                        print("Group ID: " + String(object["groupID"]))
//                        print("Share Token: " + String(object["shareToken"]))
//                        print("Member Count: " + String(object["memberCount"]))
//                        
//                        if object["memberCount"] as! Int > maxMembers {
//                            objectID = object.objectId!
//                            groupID = object["groupID"] as! String
//                            shareToken = object["shareToken"] as! String
//                            maxMembers = object["memberCount"] as! Int
//                        }
//                    }
//                }
//            }
//        }
    }
    
    // Get group information for the group of interest
    // If empty, delete it and recall checkForOpen (empty = size 1 = only admin)
    // If not empty, calls makeString()
    func checkEmpty(groupID: String, shareToken: String, objID: String) -> Void {
        var memberCount = Int()
        Alamofire.request(.GET, self.baseURL + "/groups/" + groupID + "?token=" + self.ADMIN_TOKEN) // SHOW group information
            .responseJSON { response in
                if let test = response.result.value {
                    // Find number of members
                    memberCount = test["response"]!!["members"]!!.count
                    print("Member count of " + groupID + " in GroupMe: " + String(memberCount))
                }
                if memberCount == 1 {
                    self.deleteGroup(groupID, objID: objID) //Delete group and recall checkForOpen()
                }
        }
    }
    
    // Delete group from both GroupMe and Parse
    func deleteGroup(groupID:String, objID:String) -> Void {
        var query = PFQuery(className:courseString)
        query.getObjectInBackgroundWithId(objID) {
            (object: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
                print("Error deleting group from Parse")
            } else if let object = object {
                object.deleteInBackground()
                print("Deleting " + groupID)
                Alamofire.request(.POST, self.baseURL + "/groups/" + groupID + "/destroy?token=" + self.ADMIN_TOKEN) // Delete from Alamofire
            }
        }
    }


    

}