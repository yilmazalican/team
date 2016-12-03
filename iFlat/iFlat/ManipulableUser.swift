//
//  File.swift
//  iFlat
//
//  Created by Alican Yilmaz on 02/12/2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import Foundation

protocol ManipulableUser :class
{
    var id:String? {get set}
    var name:String? {get set}
    var surname:String? {get set}
    var email:String? {get set}
    var password:String? {get set}
    var birthDate:String? {get set}
    var Gender:String? {get set}
   
    init(name:String, surname:String, email:String,password:String, birthDate:String, Gender:String)
    init()


}
enum Gender{
    case Male
    case Female
}

