//
//  CreateGroupViewController.swift
//  GroupMeTest
//
//  Created by Brian Lin on 1/16/16.
//  Copyright © 2016 Brian Lin. All rights reserved.
//
//  Based on code of the same name by Jesse Hu
//

// Note: Backend 'CREATE' calls are made in this VC

import Foundation
import UIKit
import Alamofire
import Parse
import Bolts

class CreateGroupViewController: UITableViewController, UITextFieldDelegate {
    
    // Put IBOutlet vars below
    
    @IBOutlet weak var profField: UITextField!
    @IBOutlet weak var sectionField: UITextField!
    
    
    // Put other vars below    
    var parseClassString: String!
    var subject: NSDictionary!
    var courses: NSArray!
    var selectedSubjectString: String!
    var selectedCourseString: String!
    
    //    var course: [String: String]!
    //    var delegate: GroupSelectTableViewControllerDelegate!
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var createButton: UIButton!
    

    @IBOutlet weak var fieldAlert: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide red alert label initially
        fieldAlert.hidden = true
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "dismissKeyboard"))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - User actions
    
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    

    
    @IBAction func createButtonPressed(sender: AnyObject) {
        let profName = profField.text
        let sectionNumber = sectionField.text
        
        // If fields have not been filled, un-hide red label
        if profName == "" || sectionNumber == "" {
            fieldAlert.hidden = false
        }
        else {
            // Time to make Create Group call from backend
            let myBackend = Backend()
            myBackend.makeSection(self.selectedSubjectString+self.selectedCourseString, mySection: sectionNumber!, myProf: profName!)
            self.performSegueWithIdentifier("createToDashSegue", sender: self)

        }
        
    }
    
    
        @IBAction func cancelPressed(sender: AnyObject) {
            self.navigationController?.popViewControllerAnimated(true)
            self.performSegueWithIdentifier("createToSectionCancel", sender: self)
        }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.profField {
            self.profField.becomeFirstResponder()
        } else if textField == self.sectionField {
            self.sectionField.becomeFirstResponder()
        }
        //        else if textField == self.locationField {
        //            self.view.endEditing(true)
        //        }
        return true
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "createToSectionCancel" {
            let sectionVC = segue.destinationViewController as! SectionTableViewController
            sectionVC.selectedCourseString = self.selectedCourseString
            sectionVC.selectedSubjectString = self.selectedSubjectString
            sectionVC.parseClassString = self.parseClassString
            sectionVC.courses = self.courses
            sectionVC.subject = self.subject
        }
        if segue.identifier == "createToDashSegue" {
            let dashVC = segue.destinationViewController as! DashboardTableViewController
        }
    }
}