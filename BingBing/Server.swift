//
//  Server.swift
//  BingBing
//
//  Created by Dirk Fritz on 19.11.15.
//  Copyright © 2015 HdM. All rights reserved.
//

import Foundation
import UIKit




class Server {
    // var id: Int?
    var name: String?
    var url: NSURL!
    var notes: String?
    var goodRequests: Int = 0
    var requests: Int = 0
    var score: Float = 0.0
    var lastUpdate: NSDate?
    var favicon: UIImage?
    var healthEmoji: String = ""
    
    init(name:String?, url:NSURL, notes:String?){
        self.name = name
        self.url = url
        self.notes = notes
        self.favicon = nil
    }
}