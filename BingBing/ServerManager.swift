//
//  ServerManager.swift
//  BingBing
//
//  Created by Dirk Fritz on 19.11.15.
//  Copyright © 2015 HdM. All rights reserved.
//

import Foundation
import UIKit

class ServerManager {
    let session = NSURLSession.sharedSession()
    private let good = "☀️"
    private let ok = "⛅️"
    private let bad = "⚡️"
    
    internal var servers : [Server] = []
    private var finishedRequestCounter : Int = 0
    
    static let sharedInstance = ServerManager()
    
    internal func refreshServers(completionHandler: () -> Void) {
        self.finishedRequestCounter = 0
        for server in self.servers {
            self.refresh(server, completionHandler: { () -> Void in
                self.finishedRequestCounter += 1
                if(self.finishedRequestCounter == self.servers.count) {
                    completionHandler()
                }
            })
        }
    }
    
    internal func refresh(server: Server, completionHandler: (() -> Void)?) {
        let request = NSURLRequest(URL: server.url!)
        
        let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            server.requests += 1
            if(error != nil) {
                print(server.name! + " is not available")
                print(error)
                
            } else {
                server.goodRequests += 1
                print(server.name! + " is available")
            }
            server.lastUpdate = NSDate()
            server.score = Float(server.goodRequests) / Float(server.requests)
            
            switch server.score {
            case 0..<0.5:
                server.healthEmoji = self.bad
            case 0.5..<0.9:
                server.healthEmoji = self.ok
            case 0.9...1:
                server.healthEmoji = self.good
            default:
                server.healthEmoji = ""
            }
            
            print("Score: \(server.score)")
            completionHandler?()
        })
        task.resume()
    }
}