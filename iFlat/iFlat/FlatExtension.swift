//
//  FlatExtension.swift
//  iFlat
//
//  Created by Tolga Taner on 19.12.2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import Foundation



extension Flat {
    
    
 
    func isEmpty()->Bool {
        
        if self.address == nil || self.bathroomCount == nil || self.bedCount == nil || self.bedroomCount == nil || self.city == nil || self.flatCapacity == nil || self.price == nil  {
            return true
        }
        else {
            
return false
        }
        
        
    }

}
    
