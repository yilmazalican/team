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
    var fromU:ManipulableUser
    var toU:ManipulableUser
    var flat:ManipulableFlat
    var from:Date
    var to:Date
    var accepted:Bool
    
    init(fromU:ManipulableUser, toU:ManipulableUser,flat:ManipulableFlat,from:Date,to:Date) {
        self.accepted = false
        self.fromU = fromU
        self.toU = toU
        self.flat = flat
        self.from = from
        self.to = to
    }
    
}
