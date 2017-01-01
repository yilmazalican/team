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
    var firuser = FIRUSER()
    var cities = [String]()
    
    @IBOutlet weak var locationPV: UIPickerView!
    var user = User()
    
    
    
   
    @IBOutlet weak var FromDatePicker: UIDatePicker! {
        
        didSet{
            
            searchParameter.fromParameter = setDateToString(datePicker:FromDatePicker)
        }
    }
    
    @IBOutlet weak var ToDatePicker: UIDatePicker!{
        didSet {
            searchParameter.toParameter = setDateToString(datePicker:ToDatePicker)
            
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
        self.firuser.getCities { (cities) in
            self.cities = cities
            self.locationPV.reloadAllComponents()
            self.searchParameter.whereParameter = cities[0]
        }
        self.locationPV.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
    @IBAction func fromDatePickerChanged(_ sender: UIDatePicker) {
        
        searchParameter.fromParameter = setDateToString(datePicker: FromDatePicker)
        
    }
    
   
    
    @IBAction func toDatePicker(_ sender: UIDatePicker) {
        
        searchParameter.toParameter = setDateToString(datePicker: ToDatePicker)
        
    }
    
    
    @IBAction func searchWithParameterActionButton(_ sender: Any) {
        
        
       //searchParameter.whereParameter = self.locationPV.selectedRow(inComponent: 1).description
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if  segue.identifier == "EntranceToListSegue" {
            
            
            
            
            if let controller :ListFlatViewController = segue.destination as? ListFlatViewController {
                controller.receivedFilter.pool = false
                controller.receivedFilter.city = ""
                controller.receivedFilter.bedroomCount = 0
                controller.receivedFilter.capacity = 0
                controller.receivedFilter.smoking = false
                controller.receivedFilter.bathroomCount = 0
                controller.receivedFilter.smoking = false
                controller.receivedFilter.internet = false
                controller.receivedFilter.tv = false
                controller.receivedFilter.washingMachine = false
                controller.receivedFilter.gateKeeper = false
                controller.receivedFilter.priceTo = 0
                controller.receivedFilter.fromDateTimeStamp = ""
                controller.receivedFilter.toDateTimeStamp = ""
                controller.receivedFilter.parking = false
                controller.receivedFilter.elevator = false
                controller.receivedFilter.heating = false
                controller.receivedFilter.priceFrom = 0
                controller.receivedFilter.bedCount = 0
                controller.receivedFilter.cooling = false
                
                if let city =   searchParameter.whereParameter {
                    controller.receivedFilter.city = city
                }
                if let from = searchParameter.fromParameter {
                    
                    controller.receivedFilter.fromDate = Date(dateString: from)
                }
                if let to = searchParameter.toParameter {
                    
                    controller.receivedFilter.toDate = Date(dateString:to)
                }
                if let capacity = searchParameter.numberOfSize {
                    
                    controller.receivedFilter.capacity = Int(capacity)!
                }
                

            }
        }
        
        
        
        
    }
    
    
}


extension EntranceViewController : UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate , DateToString {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0{
        return SearchParameter.sizeNum[row]
        }
        else
        {
            return self.cities[row]

        }
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView.tag == 0{
              return 1
        }
        else
        {
            return 1
        }
    
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0{
            return SearchParameter.sizeNum.count

        }
        else
        {
            return self.cities.count
        }
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView.tag == 0)
        {
            if SearchParameter.sizeNum[row] != SearchParameter.selectPeopleNum {
                
                searchParameter.numberOfSize  = SearchParameter.sizeNum[row]
                
            }
        }
        else{
            searchParameter.whereParameter = self.cities[row]
        }

        
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if pickerView.tag == 0{
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
        else
        {
            let label = UILabel()
            label.text = cities[row]
            label.textAlignment = .center
            return label
        }
        }

    
}

