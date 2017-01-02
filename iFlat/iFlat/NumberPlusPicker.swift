//
//  BedCountPicker.swift
//  iFlat
//
//  Created by Eren AY on 09/12/16.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit

// Custom Picker Class for Filter
class NumberPlusPicker: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var field : UITextField!

    var fieldOldText : String = ""
    var toolBar : UIToolbar!
    var currentSelection : String!
    public func setField( field : UITextField!){
        self.field = field
        self.fieldOldText = field.text!
        createToolBarForPicker()
        

    }
    

    

    
    /// Picker elemets array shown at picker
    var pickerElements = ["0","1","2","3","4","5","6","7","8","9"]

    
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

        currentSelection = pickerElements[row]
    }
    
    func createToolBarForPicker(){
        toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(doneFilterPicker(sender:)))
        doneButton.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(cancelFilterPicker(sender:)))
        cancelButton.tintColor = UIColor(red: 217/255, green: 217/255, blue: 100/255, alpha: 1)
        let clearButton = UIBarButtonItem(title: "Clear", style: UIBarButtonItemStyle.plain, target: self, action: #selector(clearFilterPicker(sender:)))
        clearButton.tintColor = UIColor(red: 217/255, green: 76/255, blue: 100/255, alpha: 1)
        
        toolBar.setItems([clearButton, cancelButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        field.inputAccessoryView = toolBar
        
    }
    func doneFilterPicker(sender:UIBarButtonItem){
        field.text = currentSelection
        fieldOldText = currentSelection
        field.inputView?.removeFromSuperview()
        field.inputAccessoryView?.removeFromSuperview()
        
    }
    func clearFilterPicker(sender:UIBarButtonItem){
        field.text?.removeAll()
        fieldOldText = ""
        field.inputView?.removeFromSuperview()
        field.inputAccessoryView?.removeFromSuperview()
        
    }
    func cancelFilterPicker(sender:UIBarButtonItem){
        field.text? = fieldOldText
        field.inputView?.removeFromSuperview()
        field.inputAccessoryView?.removeFromSuperview()
        
        

    }
    
}
