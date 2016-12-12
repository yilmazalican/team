//
//  FiltersViewController.swift
//  iFlat
//
//  Created by Eren AY on 09/12/16.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit

class FiltersViewController: UIViewController  {

    @IBOutlet var bedCountTextField: UITextField!
    @IBOutlet var flatCapacityTextField: UITextField!
    @IBOutlet var bedroomCountTextField: UITextField!
    @IBOutlet var bathroomCountTextField: UITextField!
    
    @IBOutlet var poolSwitch: UISwitch!
    @IBOutlet var internetSwitch: UISwitch!
    @IBOutlet var coolingSwitch: UISwitch!
    @IBOutlet var heatingSwitch: UISwitch!
    @IBOutlet var televisionSwitch: UISwitch!
    @IBOutlet var elevatorSwitch: UISwitch!
    @IBOutlet var parkingSwitch: UISwitch!
    @IBOutlet var gateKeeperSwitch: UISwitch!
    @IBOutlet var washingMachineSwitch: UISwitch!
    @IBOutlet var priceFromTextField: UITextField!    
    @IBOutlet var priceToTextField: UITextField!
    
    
    
    var numberPlusPickerObj : NumberPlusPicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPickerToFields(field: flatCapacityTextField)
        setPickerToFields(field: bedCountTextField)
        setPickerToFields(field: bedroomCountTextField)
        setPickerToFields(field: bathroomCountTextField)

    }

    
    @IBAction func showFilteredResultsButtonClicked(_ sender: Any) {
        
        var filter : FilterModel = FilterModel()
        filter.bathroomCount = self.bathroomCountTextField.text
        filter.bedCount = self.bedCountTextField.text
        filter.bedroomCount = self.bedroomCountTextField.text
        filter.cooling = String(self.coolingSwitch.isOn)
        filter.elevator = String(self.elevatorSwitch.isOn)
        filter.flatCapacity = self.flatCapacityTextField.text
        filter.gateKeeper = String(self.gateKeeperSwitch.isOn)
        filter.heating = String(self.heatingSwitch.isOn)
        filter.internet = String(self.internetSwitch.isOn)
        filter.parking = String(self.parkingSwitch.isOn)
        filter.pool = String(self.poolSwitch.isOn)
        filter.tv = String(self.televisionSwitch.isOn)
        filter.washingMachine = String(self.washingMachineSwitch.isOn)
        filter.priceFrom = self.priceFromTextField.text
        filter.priceTo = self.priceToTextField.text
        
        // send to firebase!!!
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setPickerToFields(field : UITextField){
        numberPlusPickerObj = NumberPlusPicker()
        numberPlusPickerObj.setField(field: field)
        numberPlusPickerObj.delegate = numberPlusPickerObj
        numberPlusPickerObj.dataSource = numberPlusPickerObj
        field.inputView = numberPlusPickerObj
    }




}
