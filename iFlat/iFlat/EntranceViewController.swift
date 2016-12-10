//
//  EntranceViewController.swift
//  iFlat
//
//  Created by Tolga Taner on 1.12.2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit

class EntranceViewController: UIViewController {
    
    
    var searchParameter = SearchParameter()
    
    var user = User()
   
    
    
    @IBOutlet weak var cityTextField: UITextField!{
        
        didSet{
            
   cityTextField.delegate = self
        }
    }
    
    @IBOutlet weak var FromDatePicker: UIDatePicker!{
        didSet{

            
        }
    }
    
    @IBOutlet weak var ToDatePicker: UIDatePicker!{
        didSet{
            
        }
    }
    
    @IBOutlet weak var numberPersonPicker: UIPickerView!{
        didSet {
            
          numberPersonPicker.delegate = self
            numberPersonPicker.dataSource = self

        }
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
   
    @IBAction func fromDatePickerChanged(_ sender: UIDatePicker) {
        
        searchParameter.fromParameter = setDateToString(datePicker: FromDatePicker)

    }
    
    @IBAction func whereTextFieldEnd(_ sender: UITextField) {
        
        searchParameter.whereParameter = sender.text
    }
   
    @IBAction func toDatePicker(_ sender: UIDatePicker) {
        
      searchParameter.toParameter = setDateToString(datePicker: ToDatePicker)
        
    }
   
   
   
  
    @IBAction func searchWithParameterActionButton(_ sender: Any) {

       
        
        
    }
    
    
    
  
}


extension EntranceViewController : UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate , DateToString {
    
 
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
      
        return SearchParameter.sizeNum[row]
     
        
    }
 
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
            return SearchParameter.sizeNum.count
           }

    
   
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if SearchParameter.sizeNum[row] != SearchParameter.selectPeopleNum {
            
            searchParameter.numberOfSize  = SearchParameter.sizeNum[row]
            
        }
        
        
        }
      
        
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var data:String!
        
        var label = view as! UILabel!
        if label == nil {
            label = UILabel()
        }
        
       
            data = SearchParameter.sizeNum[row]
            
            let title = NSAttributedString(string: data!, attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14.0)])
            
            label?.attributedText = title
            label?.textAlignment = .center
            
            if data == SearchParameter.selectPeopleNum {
                
                label?.textColor = UIColor.red
                
            
            
             }
            return label!
       

        }
    }

