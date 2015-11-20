//
//  OverviewTableViewController.swift
//  BingBing
//
//  Created by Dirk Fritz on 19.11.15.
//  Copyright © 2015 Dirk Fritz. All rights reserved.
//

import UIKit

class OverviewTableViewController: UITableViewController {
    
    let serverManager = ServerManager.sharedInstance
    
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.toolbarHidden = true
        if let indexPath = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        serverManager.refreshServers { () -> Void in
            self.tableView.reloadData()
        }
        self.refreshControl?.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refresh() {
        ServerManager.sharedInstance.refreshServers { () -> Void in
            self.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        }
        
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (serverManager.servers?.count)!
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("server", forIndexPath: indexPath)
        let server = serverManager.servers![indexPath.row]
        
        // Configure the cell...
        cell.textLabel?.text = server.name
        let detail = "\(server.healthEmoji)\(server.url!.absoluteString)"
        cell.detailTextLabel?.text = detail
        
        
        if(server.favicon == nil){
            server.favicon = UIImage(data: NSData(contentsOfURL: NSURL(string: (server.url?.absoluteString)! + "/favicon.ico")!)!)
        }
        if(server.favicon != nil) {
            cell.imageView?.image = imageWithImage(server.favicon!, newSize: CGSize(width: 32, height: 32))
        }
        
        return cell
    }
    
    func imageWithImage(image:UIImage, newSize:CGSize) -> UIImage {
        UIGraphicsBeginImageContext(newSize)
        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "detailSegue") {
            let detailVC = segue.destinationViewController as! DetailTableViewController
            detailVC.server = serverManager.servers![self.tableView.indexPathForSelectedRow!.row]
            detailVC.serverIdx = self.tableView.indexPathForSelectedRow!.row
        } else {
            let navVC = segue.destinationViewController as! UINavigationController
            let editVC =  navVC.childViewControllers[0] as! EditTableViewController
            editVC.title = "Add new Server"
            editVC.server = Server(name: "", url: NSURL(), notes: "")
        }
    }
    
    
}
