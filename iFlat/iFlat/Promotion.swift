//
//  Promotion.swift
//  iFlat
//
//  Created by Alican Yilmaz on 30/12/2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import Foundation
class Promotion
{
    var ID:String
    var title:String
    var discountRate:Double
    var description:String
    var isActive:Bool
    
    
    init(title:String,discountRate:Double,description:String,isActive:Bool) {
        self.ID = UUID().uuidString
        self.title = title
        self.discountRate = discountRate
        self.description = description
        self.isActive = isActive
    }
    
}
