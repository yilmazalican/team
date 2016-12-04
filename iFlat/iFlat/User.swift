//
//  User.swift
//  iFlat
//
//  Created by Alican Yilmaz on 02/12/2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import Foundation

class User:ManipulableUser
{
    var id:String?
    var name:String?
    var surname:String?
    var email:String?
    var password:String?
    var birthDate:String?
    var Gender: String?
    private var DB_ENDPOINT:FIRUSERDelegate?
    
    required init(name:String, surname:String, email:String,password:String, birthDate:String, Gender:String)
    {
        self.name = name
        self.surname = surname
        self.email = email
        self.password = password
        self.birthDate = birthDate
        self.Gender = Gender
        self.DB_ENDPOINT = FIRUSER()
    }
    
    internal required init() {
        self.DB_ENDPOINT = FIRUSER()

    }
    

  
  }
