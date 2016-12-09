//
//  BedCountPicker.swift
//  iFlat
//
//  Created by Eren AY on 09/12/16.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit

class NumberPlusPicker: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var pickerElements = ["1+","2+","3+","4+","5+","6+","7+","8+","9+"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerElements.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerElements[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
}
