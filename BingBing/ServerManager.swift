//
//  ServerManager.swift
//  BingBing
//
//  Created by Dirk Fritz on 19.11.15.
//  Copyright © 2015 HdM. All rights reserved.
//

import Foundation

class ServerManager {
    let session = NSURLSession.sharedSession()
    
    var servers : [Server]? = []
    var finishedRequestCounter : Int = 0
    
    static let sharedInstance = ServerManager()
    
    func refreshServers(completionHandler: () -> Void) {
        self.finishedRequestCounter = 0
        for server in self.servers! {
            let request = NSURLRequest(URL: server.url!)
            
            let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
                server.requests += 1
                if error != nil {
                    print(server.name!)
                    print(error)

                } else {
                    server.goodRequests += 1
                    print(server.name! + " is available")
                }
                server.score = Float(server.goodRequests) / Float(server.requests)
                print("Score: \(server.score)")
                self.finishedRequestCounter += 1
                if(self.finishedRequestCounter == self.servers?.count) {
                    completionHandler()
                }
            })
            task.resume()
        }
    }
}