//
//  DateBaby.swift
//  iFlat
//
//  Created by Alican Yilmaz on 18/12/2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import Foundation

extension Date
{
    init(dateString: String)
    {
        
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "dd/MM/yyyy"
        dateStringFormatter.locale = Locale(identifier: "TR_TR")
        dateStringFormatter.timeZone = TimeZone(secondsFromGMT: 3)
        let d = dateStringFormatter.date(from: dateString)!
        
        self.init(timeInterval: 0, since:d)

        
    }
    
    func toTimeStamp() -> Int
    {
        var a = Int(self.timeIntervalSince1970)
        let b = a % (60*60*24)
        a = a - b
        return a
    }
    
    
    
}
