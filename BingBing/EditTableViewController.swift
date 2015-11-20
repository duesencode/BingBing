//
//  EditTableViewController.swift
//  BingBing
//
//  Created by Dirk Fritz on 19.11.15.
//  Copyright © 2015 Dirk Fritz. All rights reserved.
//

import UIKit

class EditTableViewController: UITableViewController {

    var server: Server!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.text = server?.name

        urlTextField.text = server?.url?.absoluteString


        notesTextView.text = server?.notes
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelPressed(sender: UIBarButtonItem) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func savePressed(sender: UIBarButtonItem) {
        
        server?.name = nameTextField.text
        server?.url = NSURL(string: urlTextField.text!)
        server?.notes = notesTextView.text
        ServerManager.sharedInstance.servers?.append(server!)
        self.dismissViewControllerAnimated(true) { () -> Void in
            ServerManager.sharedInstance.refresh(self.server!, completionHandler: nil)
        }
    }
}
