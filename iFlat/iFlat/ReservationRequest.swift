//
//  ReservationRequest.swift
//  iFlat
//
//  Created by Alican Yilmaz on 30/12/2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import Foundation
class ReservationRequest
{
    private let dbEndpoint = FIRUSER()
    var id = UUID().uuidString
    var hostUID:String?
    var renterUID:String?
    var flatID:String?
    var timeSlots = [Int]()
    var accepted:Int?
    var date:String?

    
    init(renterUID:String, hostUID:String,flatID:String, timeSlots:[Int]) {
        self.accepted = 0
        self.timeSlots = timeSlots
        let date = Date()
        let locale = Locale(identifier: "tr-TR")
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 3)
        formatter.dateFormat = "dd/MM/yyyy HH:mm:ss:SSSS"
        formatter.locale = locale
        let result = formatter.string(from: date)
        self.date = result
        self.renterUID = renterUID
        self.hostUID = hostUID
        self.flatID = flatID
    
       
    }
    
    init()
    {
        
    }
    
}
