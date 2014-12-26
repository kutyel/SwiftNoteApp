//
//  AddNoteViewController.swift
//  NoteApp
//
//  Created by Flavio Corpa on 26/12/14.
//  Copyright (c) 2014 Flavio Corpa. All rights reserved.
//

import UIKit

class AddNoteViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var myTextField:UITextField?
    
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        println("Text value entered is: \(textField.text)")
        
        return true
    }

    @IBAction func closeAddNote(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
