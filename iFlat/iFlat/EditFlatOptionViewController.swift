//
//  EditFlatOptionViewController.swift
//  iFlat
//
//  Created by Tolga Taner on 29.12.2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit

class EditFlatOptionViewController: UIViewController {
    
    @IBOutlet weak var minusCapacityButton: UIButton!
    
    @IBOutlet weak var plusCapacityButton: UIButton!
    
    var count : Int = 0
    
      var dbFirebase = FIRUSER()
    
    var cities = [String]()
    
    
    var editingFlatOptions = Flat()
    
    @IBOutlet weak var plusBathroomButton: UIButton!
    @IBOutlet weak var minusBathroomButton: UIButton!
    
    @IBOutlet weak var plusBedButton: UIButton!
    @IBOutlet weak var minusBedButton: UIButton!
    @IBOutlet weak var plusBedroomButton: UIButton!
    @IBOutlet weak var minusBedroomButton: UIButton!
    @IBOutlet weak var capacityLabel: UILabel!{
        didSet{
            
            capacityLabel.text = String(editingFlatOptions.flatCapacity!)
        }
    }
    
    @IBOutlet weak var bedroomLabel: UILabel!{
        didSet{
            bedroomLabel.text = String(editingFlatOptions.bedroomCount!)
            
        }
    }
   
    
    @IBOutlet weak var bathroomLabel: UILabel!{
        didSet{
            
            bathroomLabel.text = String(editingFlatOptions.bathroomCount!)
        }
    }
    
    @IBOutlet weak var bedLabel: UILabel!{
        didSet{
            
             bedLabel.text = String(editingFlatOptions.bedCount!)
        }
    }
    
    
    
    @IBOutlet weak var heatingSwitch: UISwitch!{
        didSet{
            heatingSwitch.isOn = editingFlatOptions.heating!
            
        }
    }
    @IBOutlet weak var washingMachineSwitch: UISwitch!{
        didSet{
            washingMachineSwitch.isOn = editingFlatOptions.washingMachine!
            
        }
    }
    @IBOutlet weak var smokingSwitch: UISwitch!{
        didSet{
            
            smokingSwitch.isOn = editingFlatOptions.smoking!
        }
    }

    @IBOutlet weak var gateKeeperSwitch: UISwitch!{
        didSet{
            
        gateKeeperSwitch.isOn = editingFlatOptions.gateKeeper!
        }
    }
    @IBOutlet weak var parkingSwitch: UISwitch!{
        didSet{
            
            parkingSwitch.isOn = editingFlatOptions.parking!
        }
    }
    @IBOutlet weak var elevatorSwitch: UISwitch!{
        didSet{
            elevatorSwitch.isOn = editingFlatOptions.elevator!
            
        }
    }
    
    @IBOutlet weak var coolingSwitch: UISwitch!{
        didSet{
            
           coolingSwitch.isOn =  editingFlatOptions.cooling!
        }
    }
    
    @IBOutlet weak var poolSwitch: UISwitch!{
        didSet{
            
            poolSwitch.isOn = editingFlatOptions.pool!
        }
    }
   
   
    @IBOutlet weak var internetSwitch: UISwitch!{
        didSet{
            
            internetSwitch.isOn = editingFlatOptions.internet!
        }
    }
    
    
    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            
         
            
            scrollView.contentSize.height = 1300
        }
    }
    
    @IBOutlet weak var cityPicker: UIPickerView!{
        didSet{
            cityPicker.delegate = self
            cityPicker.dataSource = self
        }
    }
 
    @IBAction func heatingValueChanged(_ sender: UISwitch) {
              editingFlatOptions.heating = sender.isOn
    }
    
    
    @IBAction func elevatorValueChanged(_ sender: UISwitch) {
              editingFlatOptions.elevator = sender.isOn
    }
    
    
    @IBAction func parkingValueChanged(_ sender: UISwitch) {
              editingFlatOptions.parking = sender.isOn
    }
    
    
    @IBAction func poolValueChanged(_ sender: UISwitch) {
              editingFlatOptions.pool = sender.isOn
    }
    
    
    @IBAction func coolingValueChanged(_ sender: UISwitch) {
              editingFlatOptions.cooling = sender.isOn
    }
    
    @IBAction func gateKeeperValueChanged(_ sender: UISwitch) {
              editingFlatOptions.gateKeeper = sender.isOn
    }
    
    @IBAction func smokingValueChanged(_ sender: UISwitch) {
              editingFlatOptions.smoking = sender.isOn
    }
    
    @IBAction func washingMachineValueChanged(_ sender: UISwitch) {
              editingFlatOptions.washingMachine = sender.isOn
    }
    
    
    var oldCity = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        dbFirebase.getCities { (allCities) in
            self.cities = allCities
            
            self.cityPicker.reloadAllComponents()
        }
        
      
       
              // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    
    
    
    @IBAction func countUp(_ sender: UIButton) {
        if  sender.tag == 0 {
            
           count = editingFlatOptions.flatCapacity!
            
            
            if count == 5 {
                plusCapacityButton.isEnabled = false
                
            }
            else {
                   minusCapacityButton.isEnabled = true
              count = count + 1
                
                capacityLabel.text = String(count)
                
                editingFlatOptions.flatCapacity = count

            }
            
        }
        
        if  sender.tag == 1 {
            
            count = editingFlatOptions.bedroomCount!
            
            if count == 5 {
                plusBedroomButton.isEnabled = false
                
            }
            else {
                minusBedroomButton.isEnabled = true
                
                
            
            
            count = count + 1
            
            bedroomLabel.text = String(count)
            
            editingFlatOptions.bedroomCount = count
            }


        }
        if  sender.tag == 2 {
            
            count = editingFlatOptions.bedCount!
            if count == 5 {
                plusBedButton.isEnabled = false
                
            }
            else {
                minusBedButton.isEnabled = true
            
            
            count = count + 1
            
            bedLabel.text = String(count)
            
            editingFlatOptions.bedCount = count
            
            }
            
        }
        if  sender.tag == 3 {
             count = editingFlatOptions.bathroomCount!
            if count == 5 {
                plusBathroomButton.isEnabled = false
                
            }
            else {
                minusBathroomButton.isEnabled = true
           
            
            count = count + 1
            
            bathroomLabel.text = String(count)
            
            editingFlatOptions.bathroomCount = count
            
            }
            
        }
        
    }
    
    
    
    
    @IBAction func countDown(_ sender: UIButton) {
        
       
        
        
        if  sender.tag == 0 {
            
            count = editingFlatOptions.flatCapacity!
            
            if count == 1 {
                minusCapacityButton.isEnabled = false
                
            }
            else {
                plusCapacityButton.isEnabled = true
                
         
            
            count = count - 1
            
            capacityLabel.text = String(count)
            
            editingFlatOptions.flatCapacity = count
               }
        }
        
        if  sender.tag == 1 {
            count = editingFlatOptions.bedroomCount!

            if count == 1 {
                minusBedroomButton.isEnabled = false
                
            }
            else {
                plusBedroomButton.isEnabled = true
                

                
            count = count - 1
            
            bedroomLabel.text = String(count)
            
            editingFlatOptions.bedroomCount = count
            }
            
            
        }
        if  sender.tag == 2 {
            count = editingFlatOptions.bedCount!

            if count == 1 {
                minusBedButton.isEnabled = false
                
            }
            else {
                plusBedButton.isEnabled = true
                

                
            count = count - 1
            
            bedLabel.text = String(count)
            
            editingFlatOptions.bedCount = count
            
            }
            
            
        }
        if  sender.tag == 3 {
             count = editingFlatOptions.bathroomCount!
            if count == 1 {
                minusBathroomButton.isEnabled = false
                
            }
            else {
                plusBathroomButton.isEnabled = true
                

            count = count - 1
            
            bathroomLabel.text = String(count)
            
            editingFlatOptions.bathroomCount = count
            
            
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        
        if let controller :EditFlatViewController = segue.destination as? EditFlatViewController {
            controller.oldCity = oldCity
            controller.editingFlat = editingFlatOptions
            
    }
    }
}

extension EditFlatOptionViewController : UIPickerViewDelegate,UIPickerViewDataSource {
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
            return cities.count
            
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
     
        editingFlatOptions.city = cities[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var data:String!
        
        var label = view as! UILabel!
        if label == nil {
            label = UILabel()
        }
        
        
        data = cities[row]
        
        let title = NSAttributedString(string: data!, attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14.0)])
        
        label?.attributedText = title
        label?.textAlignment = .center
        
        
        return label!
        
        
    }

}
