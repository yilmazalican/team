//
//  UserExtension.swift
//  iFlat
//
//  Created by Tolga Taner on 24.12.2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit


extension User {
    
    
    /// This method provide control to entered value by users like email,name,surname.
    /// if user do not enter information , this method return true.
    /// Return value is boolean.
    func isUserEmpty() ->Bool{
        
        if self.email == ""  || self.name == "" || self.surname == "" {
            
            return true
        }
        else {
            
            return false
        }
        
    }
    
    
    
}
