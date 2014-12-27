//
//  AddNoteViewController.swift
//  NoteApp
//
//  Created by Flavio Corpa on 26/12/14.
//  Copyright (c) 2014 Flavio Corpa. All rights reserved.
//

import UIKit

protocol AddNoteViewControllerDelegate {
    func saveNote(controller:AddNoteViewController, noteText:String)
    func dismissAddViewController(controller:AddNoteViewController)
}

class AddNoteViewController: UIViewController, UITextFieldDelegate {

    var delegate:AddNoteViewControllerDelegate?
    @IBOutlet var myTextField:UITextField?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        delegate?.saveNote(self, noteText: textField.text)
        return true
    }

    @IBAction func closeAddNote(sender: AnyObject) {
        delegate?.dismissAddViewController(self)
    }
}
