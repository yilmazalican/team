//
//  ManipulableFlat.swift
//  iFlat
//
//  Created by Alican Yilmaz on 11/12/2016.
//  Copyright © 2016 SE 301. All rights reserved.
//
import Foundation
import UIKit
protocol ManipulableFlat :class
{
    var id:String {get set}
    var title:String? {get}
    var flatDescription:String? {get}
    var city:String? {get}
    var address:String? {get}
    var flatCapacity:Int? {get}
    var bathroomCount:Int? {get}
    var bedCount:Int? {get}
    var bedroomCount:Int? {get}
    var pool:Bool? {get}
    var internet:Bool? {get}
    var cooling:Bool? {get}
    var heating:Bool? {get}
    var tv:Bool? {get}
    var washingMachine:Bool? {get}
    var elevator:Bool? {get}
    var parking:Bool? {get}
    var smoking:Bool? {get}
    var gateKeeper:Bool? {get}
    var price:Double? {get}
    var images:[FlatImage]? {get set}
    var disabled:Bool? {get set}
    var userID:String {get set}
    var DB_ENDPOINT:FIRFlat {get set}
    
    init(title:String,flatDescription:String,city:String, address:String,flatCapacity:Int,bathRoomCount:Int,bedcount:Int,pool:Bool,internet:Bool,cooling:Bool,heating:Bool,tv:Bool,washingMachine:Bool,elevator:Bool,parking:Bool,smoking:Bool,gateKeeper:Bool,price:Double,deleted:Bool, images:[FlatImage], bedroomCount:Int)
    init()
    
}
