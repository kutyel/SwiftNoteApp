//
//  NotesTableViewController.swift
//  NoteApp
//
//  Created by Flavio Corpa on 26/12/14.
//  Copyright (c) 2014 Flavio Corpa. All rights reserved.
//

import UIKit

class NotesTableViewController: UITableViewController {

    let notes = []
    
    required init(coder aDecoder: NSCoder) {
        
        notes = ["One", "Two", "Three", "Four", "Five"]
        
        super.init(coder: aDecoder)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("noteCell") as UITableViewCell
        
        cell.textLabel?.text = notes[indexPath.row] as? String
        
        return cell
    }
}
