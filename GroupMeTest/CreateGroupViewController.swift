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
    
//    var course: [String: String]!
//    var delegate: GroupSelectTableViewControllerDelegate!
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var createButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    

    

    
//    @IBAction func cancelPressed(sender: AnyObject) {
//        self.navigationController?.popViewControllerAnimated(true)
//    }
//    
//    @IBAction func createGroupPressed(sender: AnyObject) {
//        let profName = profField.text //good
//        
//        if count(profName) > 0 {
//            // make Create Group backend call here
//            
//            // segue to Dashboard here
//        } else {
//            HudUtil.displayErrorHUD(self.view, displayText: "Professor name field must not be empty", displayTime: 1.5)
//            return
//        }
//        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
//    }
    
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
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
}
}