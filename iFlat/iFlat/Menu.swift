//
//  Menu.swift
//  iFlat
//
//  Created by Tolga Taner on 19.12.2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit



class Menu:NSObject {
    
    
        let name : MenuName
        let imageName: String = ""
        
        init(name:MenuName) {
            
            
            self.name = name
            
        
            
        }
        
    }
    
    


enum MenuName : String {
    
    case Logout = "Logout"
    
    
}
    
