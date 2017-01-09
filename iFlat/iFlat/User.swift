//
//  User.swift
//  iFlat
//
//  Created by Alican Yilmaz on 02/12/2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import Foundation
import UIKit

class User:ManipulableUser
{
    var country: String?
    var profileImage: UIImage?
    var id: String?
    var name:String?
    var surname:String?
    var email:String?
    var password:String?
    var birthDate:String?
    var Gender: String?
    var DB_ENDPOINT: FIRUSER
    


    

    required init(name:String, surname:String, email:String,password:String, birthDate:String, Gender:String, profileImage img:UIImage, country:String)
    {
        self.name = name
        self.surname = surname
        self.email = email
        self.password = password
        self.birthDate = birthDate
        self.Gender = Gender
        self.country = country
        self.profileImage = img
        DB_ENDPOINT = FIRUSER()
    }
    
    internal required init() {
        self.DB_ENDPOINT = FIRUSER()
    }

       

    
    internal func insertFlat(flt: ManipulableFlat, completion: @escaping (String?) -> ()) {
                  
    }
       
    

    
    
    

    
    // Meva Added.
    
    static let staticGender =  ["Female","Male","Other"]

    
    
      

  }
