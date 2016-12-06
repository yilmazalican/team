//
//  RenterEditOwnProfileTableViewCell.swift
//  iFlat
//
//  Created by Tolga Taner on 5.12.2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit




class RenterEditOwnProfileTableViewCell: UITableViewCell {

    
    
   static  let cellId = "renterEditProfileCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }

    @IBOutlet weak var customerNameTextField: UITextField! {
        
        didSet {
            customerNameTextField.delegate = self
            
        }
    }
    
    
   
    
    @IBOutlet weak var customerSurnameTextField: UITextField! {
        
        didSet {
            
            customerSurnameTextField.delegate = self
        }
    }
    
    
    
    
    @IBOutlet weak var emailTextField: UITextField!
    {
        
        didSet {
            
              emailTextField.delegate = self
        }
        
    }
    
    
    
    @IBOutlet weak var phoneNumTextField: UITextField!
        {
        
        didSet {
            
            phoneNumTextField.delegate = self
        }
        
    }
    
    
    
    
    @IBOutlet weak var townTextField: UITextField!
        {
        
        didSet {
            
            townTextField.delegate = self
        }
        
    }
    
    
    
    @IBOutlet weak var countryPicker: UIPickerView!{
        didSet {
            countryPicker.delegate = self
            countryPicker.dataSource = self
            
        }
    }
    
    
    
    @IBOutlet weak var birthdateDatePicker: UIDatePicker!{
        
        didSet {
            
           //TODO : USER.Date birthdateDatePicker.setDate(date: Date, animated: nil)
            
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

     
    }
    
    @IBAction func userDatePickerValueChanged(_ sender: UIDatePicker) {
      //TODO: setDateToString(datePicker: birthdateDatePicker)
        
    }
    
    
    
    @IBAction func nameEditingEnd(_ sender: UITextField) {
    }
    
    
    @IBAction func surnameEditingEnd(_ sender: UITextField) {
        
    }
    
    
    @IBAction func emailEditingEnd(_ sender: UITextField) {
    }
  
    @IBAction func phoneNumberEditingEnd(_ sender: UITextField) {
    }
    
    @IBAction func countyEditingEnd(_ sender: UITextField) {
    }
    
}


extension RenterEditOwnProfileTableViewCell  : UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate , DateToString{
    
    
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return User.allCountryList[row]
        
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return User.allCountryList.count
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
          // TODO :  User.allCountryList  = OBJECT.field
            
      
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var data:String!
        
        var label = view as! UILabel!
        if label == nil {
            label = UILabel()
        }
        
        
        data = User.allCountryList[row]
        
        let title = NSAttributedString(string: data!, attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14.0)])
        
        label?.attributedText = title
        label?.textAlignment = .center
        
     
        return label!
        
        
    }

    
    
    
    
    
}
 
