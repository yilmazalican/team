//
//  FlatExtension.swift
//  iFlat
//
//  Created by Tolga Taner on 19.12.2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import Foundation



extension Flat {
    
    
    func isImageListEmpty() ->Bool{
       if self.images?.count == 5 {
            
            return false
        }
        else {
            
            return true
        }
        
        
    }
    
    
    
    
}
