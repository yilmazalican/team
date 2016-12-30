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
    var toU:String?
    var fromU:String?
    var flat:String?
    var from:Int?
    var to:Int?
    var accepted:Int?
    var date:String?
    
    init(fromU:String, toU:String,flat:String,from:Int,to:Int) {
        self.accepted = 0
        self.toU = toU
        self.flat = flat
        self.from = from
        self.to = to
        let date = Date()
        let locale = Locale(identifier: "tr-TR")
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm:ss:SSSS"
        formatter.locale = locale
        let result = formatter.string(from: date)
        self.date = result
        self.fromU = ""
        dbEndpoint.getCurrentLoggedIn { (usr) in
            if usr == nil
            {
                fatalError()
            }
            else
            {
                self.fromU = usr!.id!
            }
        }
        
        
    }
    
    init()
    {
        
    }
    
}
