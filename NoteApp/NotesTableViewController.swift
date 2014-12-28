//
//  NotesTableViewController.swift
//  NoteApp
//
//  Created by Flavio Corpa on 26/12/14.
//  Copyright (c) 2014 Flavio Corpa. All rights reserved.
//

import UIKit

class NotesTableViewController: UITableViewController, AddNoteViewControllerDelegate {

    var notes: [String]
    var session: NSURLSession
    
    required init(coder aDecoder: NSCoder) {
        
        notes = []
        session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        loadNotes()
    }
    
    // Initial request to the API
    
    func loadNotes() {
        let requestUrl = NSMutableURLRequest(URL: NSURL(string: "http://localhost:8080/notes")!)
        let getNotesTask = session.dataTaskWithRequest(requestUrl, completionHandler: {
            (data, response, error) in
            
            var jsonError:NSError?
            let noteJson = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &jsonError) as NSArray
            
            if let err = jsonError {
                println(err.localizedDescription)
            }
            else {
                for note in noteJson {
                    self.notes.append(note["name"] as String)
                }
            }
            
            self.tableView.reloadData()
        })
        getNotesTask.resume()
    }
    
    // TableView Creation
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("noteCell") as UITableViewCell
        
        cell.textLabel?.text = notes[indexPath.row]
        
        return cell
    }
    
    // Protocol implementation
    
    func saveNote(controller: AddNoteViewController, noteText: String) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
        notes.append(noteText)

        tableView.reloadData()
        
        let newNote = [ "name" : noteText, "author" : "@kutyel" ]
        
        var writError:NSError?
        
        let json = NSJSONSerialization.dataWithJSONObject(newNote, options: NSJSONWritingOptions.PrettyPrinted, error: &writError)
        
        if let err = writError {
            println(err.localizedDescription)
        }
        else {
            let request = NSMutableURLRequest(URL: NSURL(string: "http://localhost:8080/notes/")!)
            request.HTTPMethod = "POST"
            request.HTTPBody = json
            request.setValue("application/json", forHTTPHeaderField: "Content-type")
            
            let addNoteToAPI = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) in
                println(response)
            })
            addNoteToAPI.resume()
        }
    }
    
    func dismissAddViewController(controller: AddNoteViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "ShowAddNote") {
            
            let addNoteViewController = segue.destinationViewController as AddNoteViewController
            
            addNoteViewController.delegate = self
        }
    }
}
