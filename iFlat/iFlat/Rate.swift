//
//  Rate.swift
//  iFlat
//
//  Created by Alican Yilmaz on 17/12/2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import Foundation

class Rate
{
    var rateID:String?
    var from_userID:String?
    var rate:Int?
    
    init(from_UserID:String, rate:Int)
    {
        self.rateID = UUID().uuidString
        self.from_userID = from_UserID
        self.rate = rate
    }
    init() {
        
    }
}
