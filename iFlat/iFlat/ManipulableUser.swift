//
//  File.swift
//  iFlat
//
//  Created by Alican Yilmaz on 02/12/2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import Foundation

protocol ManipulableUser
{
    var id:Int {get}
    var name:String {get set}
    var middleName:String? {get set}
    var surname:String {get set}
    var email:String {get set}
    var password:String {get set}
    var birthDate:String {get set}
    var Gender:Gender {get set}
    var DB_ENDPOINT:FIRUSER {get set}
   
    init(id:Int,name:String,middleName:String?, surname:String, email:String,password:String, birthDate:String, Gender:Gender)
}
enum Gender{
    case Male
    case Female
}

