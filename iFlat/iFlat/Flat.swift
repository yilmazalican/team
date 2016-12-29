//
//  Flat.swift
//  iFlat
//
//  Created by Alican Yilmaz on 13/12/2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import Foundation
import UIKit
class Flat: ManipulableFlat {

    var published: Bool?
    var disabled: Bool?
    var DB_ENDPOINT:FIRFlat
    var title:String?
    var flatDescription:String?
    var city:String?
    var address:String?
    var flatCapacity:Int?
    var bathroomCount:Int?
    var bedCount:Int?
    var bedroomCount:Int?
    var pool:Bool?
    var internet:Bool?
    var cooling:Bool?
    var heating:Bool?
    var tv:Bool?
    var washingMachine:Bool?
    var elevator:Bool?
    var parking:Bool?
    var smoking:Bool?
    var gateKeeper:Bool?
    var price:Double?
    var images:[FlatImage]?
    var userID:String
    var id = FIRREF.instance().getRef().childByAutoId().key


    //
    // Alican bunları ekler misin?
    // Aynı şekilde aşağısı da düzenlenecek
    // init func
    //
    // var availableDateFrom:String?
    // var availableDateTo:String?
    // var flatRating:Int?
    // var flatOwnerID:String?
    //
    // ----------------
    //
    // Also,
    // Can you write a func named getOwnerInfo() that return me flatOwnerName & flatOwnerImage by using flatOwnerID
    //
    //

    internal required init(title: String, flatDescription: String, city: String, address: String, flatCapacity: Int, bathRoomCount: Int, bedcount: Int, pool: Bool, internet: Bool, cooling: Bool, heating: Bool, tv: Bool, washingMachine: Bool, elevator: Bool, parking: Bool, smoking: Bool, gateKeeper: Bool, price: Double, deleted: Bool, images: [FlatImage], bedroomCount: Int, disabled: Bool, published: Bool) {
        self.title = title
        self.flatDescription = flatDescription
        self.city = city
        self.address = address
        self.flatCapacity = flatCapacity
        self.bathroomCount = bathRoomCount
        self.bedCount = bedcount
        self.bedroomCount = bedroomCount
        self.pool = pool
        self.internet = internet
        self.cooling = cooling
        self.heating = heating
        self.tv = tv
        self.washingMachine = washingMachine
        self.elevator = elevator
        self.parking = parking
        self.smoking = smoking
        self.gateKeeper = gateKeeper
        self.price = price
        self.images = images
        self.DB_ENDPOINT = FIRFlat()
        self.disabled = false
        self.published = true
        self.userID = self.DB_ENDPOINT.setOwnerID()
       
        
    }
    
    internal required init() {
        self.published = true
        self.disabled = false
        self.DB_ENDPOINT = FIRFlat()
        self.userID = self.DB_ENDPOINT.setOwnerID()

    }
    

}

  


    
