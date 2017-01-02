//
//  FlatExtension.swift
//  iFlat
//
//  Created by Tolga Taner on 19.12.2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import Foundation



extension Flat {
    
    
    /// This method provide control to entered value by flats.
    /// if flat do not enter information , this method return true.
    /// Return value is boolean.
    func isEmpty()->Bool {
        
        if self.address == nil || self.bathroomCount == nil || self.bedCount == nil || self.bedroomCount == nil || self.city == nil || self.flatCapacity == nil || self.price == nil  {
            return true
        }
        else {
            
return false
        }
        
        
    }

}
    
