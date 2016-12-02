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
    var id:Int
    var name:String
    var middleName:String?
    var surname:String
    var email:String
    var password:String
    var birthDate:String
    var Gender:Gender
    var DB_ENDPOINT:FIRUSER
    
    required init(id:Int,name:String,middleName:String?, surname:String, email:String,password:String, birthDate:String, Gender:Gender)
    {
        self.id = id
        self.name = name
        self.middleName = middleName
        self.surname = surname
        self.email = email
        self.password = password
        self.birthDate = birthDate
        self.Gender = Gender
        self.DB_ENDPOINT = FIRUSER()
    }
    
    func Register()
    {
        self.DB_ENDPOINT.insert(usr: self){
        }
    }
    
    func EditInfo(usr:ManipulableUser)
    {
        self.DB_ENDPOINT.edit(usr: usr){
        }
    }
    
    func delete()
    {
        self.DB_ENDPOINT.delete(usr: self){
        }
    }
    
    func Login()
    {
        self.DB_ENDPOINT.Login(usr: self){
        }
    }
    

    

    
}
