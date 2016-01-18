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

class CreateGroupViewController: UITableViewController, UITextFieldDelegate {
    
    // Put IBOutlet vars below
    @IBOutlet weak var profField: UITextField!
    
    
    // Put other vars below
    var noneSelected = true
    var expanded = false
    
    var course: [String: String]!
//    var delegate: GroupSelectTableViewControllerDelegate!
    
//    @IBOutlet var courseLabel: UILabel!
//    @IBOutlet var groupNameField: UITextField!
//    @IBOutlet var descriptionField: UITextField!
//    @IBOutlet var locationField: UITextField!
    
//    @IBOutlet var dateTimeCell: UITableViewCell!
//    @IBOutlet var datePicker: UIDatePicker!
//    @IBOutlet var datePickerCell: UITableViewCell!
//    @IBOutlet var dateButton: UIButton!
//    @IBOutlet var noneButton: UIButton!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var sectionPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "dismissKeyboard"))
//        self.courseLabel.text = self.course["course_name"]
//        self.noneButton.highlighted = true
//        self.datePicker.addTarget(self, action: "datePickerChanged:", forControlEvents: UIControlEvents.ValueChanged)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - User actions
    
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
//    @IBAction func dateButtonPressed(sender: UIButton) {
//        dateTimePressed()
//    }
    
    
    
//    func dateTimePressed() {
//        self.noneSelected = false
//        self.noneButton.highlighted = true
//        self.dateButton.titleLabel?.alpha = 1.0
//        self.datePicker.alpha = 1.0
//        self.view.endEditing(true)
//    }
    
//    func datePickerChanged(datePicker: UIDatePicker) {
//        dateTimePressed()
//        self.dateButton.setTitle(Utilities.getFormattedTextFromDate(datePicker.date), forState: UIControlState.Normal)
//    }
    
//    @IBAction func noneButtonPressed(sender: UIButton) {
//        self.noneSelected = true
//        self.dateButton.highlighted = true
//        self.dateButton.titleLabel?.alpha = 0.25
//        self.datePicker.alpha = 0.25
//        self.view.endEditing(true)
//    }
    
    @IBAction func cancelPressed(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func createGroupPressed(sender: AnyObject) {
        let profName = profField.text //good
        
        if count(profName) > 0 {
            // make Create Group backend call here
            
            // segue to Dashboard here
        } else {
            HudUtil.displayErrorHUD(self.view, displayText: "Professor name field must not be empty", displayTime: 1.5)
            return
        }
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.groupNameField {
            self.descriptionField.becomeFirstResponder()
        } else if textField == self.descriptionField {
            self.locationField.becomeFirstResponder()
        } else if textField == self.locationField {
            self.view.endEditing(true)
        }
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
