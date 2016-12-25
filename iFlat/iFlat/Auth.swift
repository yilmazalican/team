//
//  Auth.swift
//  iFlat
//
//  Created by Özge Meva Demiröz on 21/12/2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import Foundation

extension User
{
    func insertUser(user:ManipulableUser, completion: @escaping (String?) -> ())
    {
        self.DB_ENDPOINT.insert(usr: user) { (error) in
            if error != nil
            {
                print(error)
            }
            else
            {
                print("Kullanici ekleme basarili")
                completion(error)
            }
        }
    }
    
    func loginUser ( email:String, password:String, completion: @escaping (String?) -> ()) {
        
        self.DB_ENDPOINT.loginByEmailAndPassword(email: email, password: password) { (error) in
            if error  != nil {
                print(error)
            }
            
            else {
                completion(error)
            }
        }
    }
    
   
    
    
    
  
        
    
    }
    
    
}
