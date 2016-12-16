//
//  FlatOptionTableViewCell.swift
//  iFlat
//
//  Created by Tolga Taner on 13.12.2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit

protocol FlatOptionValuesDelegate{
    func getOptionValues()
    
}


class FlatOptionTableViewCell: UITableViewCell {

   
    @IBOutlet weak var priceTextfield: UITextField!{
        didSet{
         priceTextfield.delegate = self
        }
    }
    
    @IBOutlet weak var bedPickerView: UIPickerView!{
        
        didSet {
            
            bedPickerView.dataSource = self
            
            bedPickerView.delegate = self
        }
    }
    @IBOutlet weak var bedroomPicker: UIPickerView!{
        
        didSet{
            
            bedroomPicker.dataSource = self
            bedroomPicker.delegate = self
        }
    }
    
    static let cellId = "flatOptionCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    // Switch
    
    
    
    @IBAction func internetSwitchValueChanged(_ sender: UISwitch) {
        //TODO:SET MODEL'S PROPERTY
        
    }
    
    @IBAction func poolSwitchValueChanged(_ sender: UISwitch) {
    }
    
    @IBAction func coolingSwitchValueChanged(_ sender: UISwitch) {
    }
    
    @IBAction func heatingSwitchValueChanged(_ sender: UISwitch) {
    }
    
    @IBAction func washingSwitchValueChanged(_ sender: UISwitch) {
    }
    
    @IBAction func elevatorSwitchValueChanged(_ sender: UISwitch) {
    }
   
    @IBAction func parkingSwitchValueChanged(_ sender: UISwitch) {
    }
    
    @IBAction func gateKeeperSwitchValueChanged(_ sender: UISwitch) {
    }
    
    
    @IBAction func smokingSwitchValueChanged(_ sender: UISwitch) {
    }
    
    
    
    
    
    
    
    
    
    

}

extension FlatOptionTableViewCell:UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true 
    }
    

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
       
        if pickerView.tag == 0 {
            
                return SearchParameter.bedroomSize[row]
        }
        
        else {
            
            return SearchParameter.roomSize[row]
        }
        
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
        return SearchParameter.bedroomSize.count
            
        }

        else {
       return SearchParameter.roomSize.count
            
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        if pickerView.tag == 0 {
            
            var data:String!
            var label = view as! UILabel!
            if label == nil {
                label = UILabel()
            }
            
            
            data = SearchParameter.bedroomSize[row]
            
            let title = NSAttributedString(string: data!, attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14.0)])
            
            label?.attributedText = title
            label?.textAlignment = .center
            
            if data == SearchParameter.selectBedroom {
                
                label?.textColor = UIColor.red
                
                
            }
            return label!
        }
        
        else {
            
            var data:String!
            var label = view as! UILabel!
            if label == nil {
                label = UILabel()
            }
            
            
            data = SearchParameter.roomSize[row]
            
            let title = NSAttributedString(string: data!, attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14.0)])
            
            label?.attributedText = title
            label?.textAlignment = .center
            
            if data == SearchParameter.selectBed {
                
                label?.textColor = UIColor.red
                
                
                
            }
            return label!
        }
        
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
     
        
        if pickerView.tag == 0 {
            
             //TODO :  User.allCountryList  = OBJECT.field  
        }
        
        else {
            
            
            
        }
        
        
    }
    
    
    

}
