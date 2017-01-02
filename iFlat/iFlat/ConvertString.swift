//
//  StringExtension.swift
//  iFlat
//
//  Created by Tolga Taner on 6.12.2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import Foundation
import UIKit



protocol DateToString {
   
    
}

/// This  method is date picker convert "/" to string
/// Return value is string from date picker.
extension DateToString {
    
     func setDateToString(datePicker:UIDatePicker)->String{
        
          let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
       
       return  dateFormatter.string(from: datePicker.date)
            
      
    }
    
   
    
}
