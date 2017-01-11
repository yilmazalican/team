//
//  FlatCalendarItem.swift
//  iFlat
//
//  Created by Alican Yilmaz on 10/01/2017.
//  Copyright © 2017 SE 301. All rights reserved.
//

import Foundation
class FlatCalendarItem{
    var day:Int
    var isAvailable:Bool
    
    init(day:Int,IsAvailable:Bool) {
        self.day = day
        self.isAvailable = IsAvailable
    }
}
