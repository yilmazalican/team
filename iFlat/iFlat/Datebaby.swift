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
        dateStringFormatter.locale = Locale(identifier: "tr_TR")
        let d = dateStringFormatter.date(from: dateString)!
        
        self.init(timeInterval: 0, since:d)
        Date(dateString: "12/05/2016")
        
    }
    
    func toTimeStamp() -> String
    {
        let a = Int(self.timeIntervalSince1970)
        return String(a)
    }
    
    
    
}
