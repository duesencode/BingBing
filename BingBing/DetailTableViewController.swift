//
//  DetailTableViewController.swift
//  BingBing
//
//  Created by Dirk Fritz on 19.11.15.
//  Copyright © 2015 Dirk Fritz. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController, UIActionSheetDelegate {
    
    var server: Server!
    var serverIdx: Int!
    
    @IBOutlet weak var nameCell: UITableViewCell!
    @IBOutlet weak var urlCell: UITableViewCell!
    @IBOutlet weak var lastUpdateCell: UITableViewCell!
    @IBOutlet weak var availabilityCell: UITableViewCell!
    @IBOutlet weak var notesTextView: UITextView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        nameCell.detailTextLabel!.text = server.name
        print(server.name)
        print(nameCell.detailTextLabel?.text)
        urlCell.detailTextLabel?.text = server.url?.absoluteString
        lastUpdateCell.detailTextLabel?.text = server.lastUpdate?.description
        availabilityCell.detailTextLabel?.text = "\(server.healthEmoji) \(Int(server.score*100))%"
        notesTextView.text = server.notes
        self.tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.toolbarHidden = false
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func deletePressed(sender: UIBarButtonItem) {
        let alertCtrl = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertCtrl.addAction(cancelAction)
        let deleteAction = UIAlertAction(title: "Delete server", style: .Destructive) { (action) -> Void in
            ServerManager.sharedInstance.servers.removeAtIndex(self.serverIdx)
            
            self.navigationController!.popToRootViewControllerAnimated(true)
        }
        alertCtrl.addAction(deleteAction)
        self.presentViewController(alertCtrl, animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navVC = segue.destinationViewController as! UINavigationController
        let editVC =  navVC.childViewControllers[0] as! EditTableViewController
        editVC.title = "Edit"
        editVC.server = server
    }
}
