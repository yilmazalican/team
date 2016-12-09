//
//  FiltersViewController.swift
//  iFlat
//
//  Created by Eren AY on 09/12/16.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit

class FiltersViewController: UIViewController  {

    @IBOutlet var flatCapacityTextField: UITextField!
    //@IBOutlet var flatCapacity: UIPickerView!
    var numberPlusPickerObj : NumberPlusPicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberPlusPickerObj = NumberPlusPicker()
        numberPlusPickerObj.delegate = numberPlusPickerObj
        numberPlusPickerObj.dataSource = numberPlusPickerObj
        flatCapacityTextField.inputView = numberPlusPickerObj
        //(flatCapacityTextField.View).delegate = flatCapacityObj
        //flatCapacityTextField.dataSource = flatCapacityObj
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    




}
