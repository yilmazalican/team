//
//  EditFlatOptionViewController.swift
//  iFlat
//
//  Created by Tolga Taner on 29.12.2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit

class EditFlatOptionViewController: UIViewController {
    @IBOutlet weak var heatingSwitch: UISwitch!
    @IBOutlet weak var washingMachineSwitch: UISwitch!
    @IBOutlet weak var smokingSwitch: UISwitch!

    @IBOutlet weak var gateKeeperSwitch: UISwitch!
    @IBOutlet weak var parkingSwitch: UISwitch!
    @IBOutlet weak var elevatorSwitch: UISwitch!
    
    @IBOutlet weak var coolingSwitch: UISwitch!
    
    @IBOutlet weak var poolSwitch: UISwitch!
   
    @IBOutlet weak var cityPicker: UIPickerView!
    @IBOutlet weak var capacityPicker: UIPickerView!
    
    @IBOutlet weak var bedroomPicker: UIPickerView!
    
    @IBOutlet weak var bathroomPicker: UIPickerView!
 
    @IBOutlet weak var bedPicker: UIPickerView!
    
    
    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            
         
            
            scrollView.contentSize.height = 1280
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  
}
