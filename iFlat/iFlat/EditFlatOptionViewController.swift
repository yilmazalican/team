//
//  EditFlatOptionViewController.swift
//  iFlat
//
//  Created by Tolga Taner on 29.12.2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit

class EditFlatOptionViewController: UIViewController {
    
    
    var count : Int = 0
    
    var editingFlatOptions = Flat()
    
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
            
         
            
            scrollView.contentSize.height = 1400
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
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    
    
    
    @IBAction func countUp(_ sender: UIButton) {
        if  sender.tag == 0 {
            
           count = editingFlatOptions.flatCapacity!
            
            count = count + 1
            
            capacityLabel.text = String(count)

              editingFlatOptions.flatCapacity = count
            
        }
        
        if  sender.tag == 1 {
            count = editingFlatOptions.bedroomCount!
            
            count = count + 1
            
            bedroomLabel.text = String(count)
            
            editingFlatOptions.bedroomCount = count
            


        }
        
    }
    
    
    
    
    @IBAction func countDown(_ sender: UIButton) {
        if  sender.tag == 0 {
            
            count = editingFlatOptions.flatCapacity!
            
            count = count - 1
            
            capacityLabel.text = String(count)
            
            editingFlatOptions.flatCapacity = count
            
        }
        
        if  sender.tag == 1 {
            
            count = editingFlatOptions.bedroomCount!
            
            count = count - 1
            
            bedroomLabel.text = String(count)
            
            editingFlatOptions.bedroomCount = count
            
            
            
        }

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        
        if let controller :EditFlatViewController = segue.destination as? EditFlatViewController {
            
            controller.editingFlat = editingFlatOptions
            
    }
    }
}
