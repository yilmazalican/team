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
    

    var filter : FilterModel?

    
    var numberPlusPickerObj : NumberPlusPicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPickerToFields(field: flatCapacityTextField)
        setPickerToFields(field: bedCountTextField)
        setPickerToFields(field: bedroomCountTextField)
        setPickerToFields(field: bathroomCountTextField)

        
        initUI()

    }

    func initUI(){
        if(filter?.bathroomCount != nil){
            self.bathroomCountTextField.text = String(describing: (filter?.bathroomCount)!)
        }
        if(filter?.bedCount != nil){
        self.bedCountTextField.text = String(describing: (filter?.bedCount)!)
        }
        if(filter?.bedroomCount != nil){
        self.bedroomCountTextField.text = String(describing: (filter?.bedroomCount)!)
        }
        if(filter?.capacity != nil){
        self.flatCapacityTextField.text = String(describing: (filter?.capacity)!)
        }
        
        self.coolingSwitch.setOn((filter?.cooling)!, animated: false)
        self.elevatorSwitch.setOn((filter?.elevator)!, animated: false)
        self.gateKeeperSwitch.setOn((filter?.gateKeeper)!, animated: false)
        self.heatingSwitch.setOn((filter?.heating)!, animated: false)
        self.internetSwitch.setOn((filter?.internet)!, animated: false)
        self.parkingSwitch.setOn((filter?.parking)!, animated: false)
        self.poolSwitch.setOn((filter?.pool)!, animated: false)
        self.televisionSwitch.setOn((filter?.tv)!, animated: false)
        self.washingMachineSwitch.setOn((filter?.washingMachine)!, animated: false)
        
        if(filter?.priceFrom != nil){
        self.priceFromTextField.text = String(describing: (filter?.priceFrom)!)
        }
        if(filter?.priceTo != nil){
        self.priceToTextField.text = String(describing: (filter?.priceTo)!)
        }
    }
    
    @IBAction func showFilteredResultsButtonClicked(_ sender: Any) {
        
        //var filter : FilterModel = FilterModel()
        filter?.bathroomCount = Int(self.bathroomCountTextField.text!)
        filter?.bedCount = Int(self.bedCountTextField.text!)
        filter?.bedroomCount = Int(self.bedroomCountTextField.text!)
        filter?.cooling = (self.coolingSwitch.isOn)
        filter?.elevator = (self.elevatorSwitch.isOn)
        filter?.capacity = Int(self.flatCapacityTextField.text!)
        filter?.gateKeeper = (self.gateKeeperSwitch.isOn)
        filter?.heating = (self.heatingSwitch.isOn)
        filter?.internet = (self.internetSwitch.isOn)
        filter?.parking = (self.parkingSwitch.isOn)
        filter?.pool = (self.poolSwitch.isOn)
        filter?.tv = (self.televisionSwitch.isOn)
        filter?.washingMachine = (self.washingMachineSwitch.isOn)
        filter?.priceFrom = Double(self.priceFromTextField.text!)
        filter?.priceTo = Double(self.priceToTextField.text!)

        
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


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let listFlatVC = navigationController.topViewController as! ListFlatViewController
        listFlatVC.receivedFilter = self.filter!
    }


}
