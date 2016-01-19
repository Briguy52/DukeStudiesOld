//
//  CreateGroupViewController.swift
//  GroupMeTest
//
//  Created by Brian Lin on 1/16/16.
//  Copyright © 2016 Brian Lin. All rights reserved.
//
//  Based on code of the same name by Jesse Hu
//

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
    var noneSelected = true
    var expanded = false
    var selectedSubjectString: String!
    var selectedCourseString: String!
    var parseClassString: String!
    
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
    
<<<<<<< HEAD
    //Tried to call the create group method from AppDelegate.swift
    //Also, don't we need to pass in course name? I'm not sure how we inherit variables 
    //from other "view controllers" 
    @IBAction func createButtonPressed(segue: UIStoryboardSegue, sender: AnyObject) {
        let profName = profField.text
        let sectionNumber = sectionField.text
        let appDele = AppDelegate()
        
        if !(profName!.isEmpty) {
            // make Create Group backend call here
            appDele.makeSection(profName!, mySection: sectionNumber!)
            // segue to Dashboard here
            if segue.identifier == "ShowDashSegue"{
                segue.destinationViewController as! DashboardTableViewController
        }
//        else {
//            HudUtil.displayErrorHUD(self.view, displayText: "Professor name field must not be empty", displayTime: 1.5)
//            return
//        }
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
//    func dateTimePressed() {
//        self.noneSelected = false
//        self.noneButton.highlighted = true
//        self.dateButton.titleLabel?.alpha = 1.0
//        self.datePicker.alpha = 1.0
//        self.view.endEditing(true)
//    }
    

=======
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
>>>>>>> 6da7f1e9d7bf997c8eabba221f0301e65fae2b31
    
    
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
        }
//        if segue.identifier == "createToDashSegue" {
//            let dashVC = segue.destinationViewController as! DashboardTableViewController
//        }
    }

    
}
}