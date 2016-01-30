//
//  SubjectTableViewController.swift
//  GroupMeTest
//
//  Created by Brian Lin on 1/15/16.
//  Copyright © 2016 Brian Lin. All rights reserved.
//
//  Based heavily on Jesse Hu's code of the same name

// Note: No backend methods should be called in this VC

import UIKit

class SubjectTableViewController: UITableViewController, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating {
    
    var parseClassString: String!
    var subjects: NSArray!
    var courses: NSArray!
    var selectedSubject: NSDictionary!    
    var filteredSubjects: NSArray!
    var searchController: UISearchController!

    
    //    @IBOutlet var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
        
        if let path = NSBundle.mainBundle().pathForResource("courses", ofType: "json") {
            if let jsonData = NSData.dataWithContentsOfMappedFile(path) as? NSData {
                let jsonResult: NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary
                self.subjects = jsonResult.objectForKey("subjects") as! NSArray!
            }
        }
        
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.delegate = self
        self.searchController.searchBar.sizeToFit()
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.tableView.tableHeaderView = self.searchController.searchBar
        self.definesPresentationContext = true;
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.searchController.active {
            return self.filteredSubjects.count
        }
        return self.subjects.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        // Return FILTERED results when searchController (ie search bar) is active
        if self.searchController.active {
            if let subject = self.filteredSubjects[indexPath.row] as? NSDictionary {
                if let subjectCode = subject["code"] as? String {
                    cell.textLabel?.text = subjectCode
                }
                if let subjectDesc = subject["desc"] as? String {
                    cell.detailTextLabel?.text = subjectDesc
                }
            }
        }
            
            // Return UNFILTERED results when searchController (ie search bar) is not in use
        else {
            if let subject = self.subjects[indexPath.row] as? NSDictionary {
                if let subjectCode = subject["code"] as? String {
                    cell.textLabel?.text = subjectCode
                }
                if let subjectDesc = subject["desc"] as? String {
                    cell.detailTextLabel?.text = subjectDesc
                }
            }
        }
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if self.searchController.active {
            if let subject = self.filteredSubjects[indexPath.row] as? NSDictionary {
                parseClassString = subject["code"]! as! String
                if let courses = subject["courses"] as? NSArray {
                    self.selectedSubject = subject
                    self.courses = courses
                    self.performSegueWithIdentifier("subjectToCourseSegue", sender: self)
                }
            }
        }
        else {
            if let subject = self.subjects[indexPath.row] as? NSDictionary {
                parseClassString = subject["code"]! as! String
                if let courses = subject["courses"] as? NSArray {
                    self.selectedSubject = subject
                    self.courses = courses
                    self.performSegueWithIdentifier("subjectToCourseSegue", sender: self)
                }
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "subjectToCourseSegue" {
            let courseVC = segue.destinationViewController as! CourseTableViewController
            courseVC.selectedSubjectString = self.parseClassString
            courseVC.parseClassString = self.parseClassString
            courseVC.subject = self.selectedSubject
            courseVC.courses = self.courses
        }
    }
    
    // MARK: - UISearchControllerDelegate
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchString = searchController.searchBar.text
        
        let predicate = NSPredicate(format: "code contains[c] %@ OR desc contains[c] %@", argumentArray: [searchString!, searchString!])
        self.filteredSubjects = self.subjects.filteredArrayUsingPredicate(predicate)
        
        self.tableView.reloadData()
    }
    
}
