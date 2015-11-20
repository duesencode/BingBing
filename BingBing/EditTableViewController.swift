//
//  EditTableViewController.swift
//  BingBing
//
//  Created by Dirk Fritz on 19.11.15.
//  Copyright © 2015 Dirk Fritz. All rights reserved.
//

import UIKit

class EditTableViewController: UITableViewController {

    var server: Server?
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let server = self.server {
            if let name = server.name {
                    nameTextField.text = name
            }
            urlTextField.text = server.url.absoluteString
            if let notes = server.notes {
                notesTextView.text = notes
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelPressed(sender: UIBarButtonItem) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func savePressed(sender: UIBarButtonItem) {
        let name = nameTextField.text
        let notes = notesTextView.text
        if let url = NSURL(string: urlTextField.text!) {
            if(!UIApplication.sharedApplication().canOpenURL(url)) {
                let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
                let alertCtrl = UIAlertController(title: "Enter valid URL", message: nil, preferredStyle: .Alert)
                alertCtrl.addAction(action)
                self.presentViewController(alertCtrl, animated: true, completion: nil)
            } else {
                if(self.server != nil) {
                    self.server!.name = name
                    self.server!.url = url
                    self.server!.notes = notes
                } else {
                    self.server = Server(name: name, url: url, notes: notes)
                    ServerManager.sharedInstance.servers.append(server!)
                }
                
                self.dismissViewControllerAnimated(true) { () -> Void in
                    ServerManager.sharedInstance.refresh(self.server!, completionHandler: nil)
                }
            }
        }
        


    }
}
