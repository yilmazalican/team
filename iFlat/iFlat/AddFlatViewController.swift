//
//  AddFlatViewController.swift
//  iFlat
//
//  Created by Tolga Taner on 13.12.2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import MobileCoreServices
import UIKit

class AddFlatViewController: UIViewController {
    
    
    
    var cities = [String]()
    
    var dbFirebase = FIRUSER()
    
    var dbFirebaseFlat = FIRFlat()

    var flatImage = [FlatImage]()
    
   
    
    var addingFlat : Flat = {
        
        var flat = Flat()
        
        
        flat.heating = false
        flat.cooling = false
        flat.washingMachine = false
        flat.elevator = false
        flat.internet = false
        flat.parking = false
        flat.pool = false
        flat.smoking = false
        flat.tv = false
        flat.gateKeeper = false
        flat.city = "Adana"
        
        return flat
        
    }()
    @IBOutlet weak var capacityPickerView: UIPickerView!{
        didSet{
            
            
            capacityPickerView.delegate = self
            
            capacityPickerView.dataSource = self
        }
    }
    
    

    @IBOutlet weak var bathroomPickerView: UIPickerView!{
        
        didSet{
            
            
            bathroomPickerView.delegate = self
            
            bathroomPickerView.dataSource = self
        }
    }
    
    @IBOutlet weak var priceTextField: UITextField!{
        didSet{
            
            priceTextField.delegate = self
        }
    }
    
    
    @IBOutlet weak var bedPickerView: UIPickerView!{
        didSet{
            
            bedPickerView.delegate = self
            
            bedPickerView.dataSource = self

        }
    }

    @IBOutlet weak var addressTextView: UITextView!{
        
        didSet{
            
             addressTextView.layer.cornerRadius = 10
            addressTextView.delegate = self
        }
    }
    
 
  
  
    @IBOutlet weak var internetSwitch: UISwitch!
    
    @IBOutlet weak var elevatorSwitch: UISwitch!
   
    @IBOutlet weak var coolingSwitch: UISwitch!
    
    @IBOutlet weak var smokingSwitch: UISwitch!
    @IBOutlet weak var cityPickerView: UIPickerView!{
        didSet{
            
            cityPickerView.delegate = self
            
            cityPickerView.dataSource = self
        }
    }
    
    @IBOutlet weak var parkingSwitch: UISwitch!
    @IBOutlet weak var washingSwitch: UISwitch!
    @IBOutlet weak var poolSwitch: UISwitch!
    @IBOutlet weak var bedroomPickerView: UIPickerView!{
        didSet{
            bedroomPickerView.delegate = self
            
            bedroomPickerView.dataSource = self
            
        }
    }
    
    
    
    @IBOutlet weak var gateKeeperSwitch: UILabel!
    
    
    @IBOutlet weak var heatingSwitch: UISwitch!
    @IBOutlet weak var flatDescriptionTextView: UITextView!{
        
        didSet {
            
        flatDescriptionTextView.delegate = self
        flatDescriptionTextView.layer.cornerRadius = 10
            
        }
    }
    
    
    @IBOutlet var popUpView: UIView!
    
       
    @IBOutlet weak var flatTitleTextField: UITextField!{
        
        didSet{
            
            flatTitleTextField.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.indicator.stopAnimating()
       

       
        dbFirebase.getCities { (allCities) in
            self.cities = allCities
            
            self.cityPickerView.reloadAllComponents()
        }

       
      
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }
    
    
    @IBAction func titleTextFieldEditingEnd(_ sender: UITextField) {
        addingFlat.title = sender.text
    }
   
    @IBAction func priceTextFieldDidEnding(_ sender: UITextField) {
        addingFlat.price = Double(sender.text!)
    }
  

 

    @IBAction func showOptionButtonAction(_ sender: Any) {
              self.showFlatOptionsPopUp()
    }
   
  
    
   
    
    
    
    @IBAction func elevatorValueChanged(_ sender: UISwitch) {
        addingFlat.elevator = sender.isOn
    }
    
    @IBAction func internetValueChanged(_ sender: UISwitch) {
        
        addingFlat.internet = sender.isOn
        
    }
    
    @IBAction func coolingValueChanged(_ sender: UISwitch) {
    addingFlat.cooling = sender.isOn
    }
   
    @IBAction func gateKeeperValueChanged(_ sender: UISwitch) {
        addingFlat.gateKeeper = sender.isOn
    }
    
    @IBAction func smokingValueChanged(_ sender: UISwitch) {
       addingFlat.smoking = sender.isOn
        
    }
    
    @IBAction func poolValueChanged(_ sender: UISwitch) {
        addingFlat.pool = sender.isOn
    }
    @IBAction func washingValueChanged(_ sender: UISwitch) {
        addingFlat.washingMachine = sender.isOn
    }
    @IBAction func parkingValueChanged(_ sender: UISwitch) {
       addingFlat.parking = sender.isOn
    }
    
    
    @IBAction func heatingValueChanged(_ sender: UISwitch) {
        addingFlat.heating = sender.isOn
    }
    private func showFlatOptionsPopUp() {
        
        self.view.addSubview(popUpView)
        
        popUpView.center = self.view.center
  
        
    }
    
    @IBAction func optionActionFinished(_ sender: Any) {
        
        
        popUpView.removeFromSuperview()
        

        
    }
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
 
    @IBAction func addFlatButtonAction(_ sender: Any) {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers

        addingFlat.images = flatImage
        
        if addingFlat.isEmpty(){
            
            showAlert(title: "Error", message: "Fill in the all blanks.")
            
        }

        else {
            self.indicator.startAnimating()

            
            dbFirebase.getCurrentLoggedIn(completion: { (currentUser) in
               self.addingFlat.userID = (currentUser?.id)!
                
                self.dbFirebaseFlat.insertFlat(flt: self.addingFlat) { (err) in
                    
                    self.dbFirebaseFlat.getFlatImages(flatID: self.addingFlat.id, completion: { (imgs) in
                 
                            self.indicator.stopAnimating()
                            
                        
                    })
                    for vc in viewControllers {
                        if(vc is SpacesVC){
                            self.navigationController!.popToViewController(vc, animated: true)
                        }
                    }


                    
                }

            })
            
        }
    }
    
    

    }
    



extension AddFlatViewController : UITextFieldDelegate,UITextViewDelegate,ShowAlert,UIPickerViewDelegate,UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var data:String!
       
        
        if pickerView.tag == 0 {
             data =  cities[row]
            
        }
        
        if pickerView.tag == 1 {
            
            data = SearchParameter.bedroomSize[row]

            
        }
        
        if pickerView.tag == 2 {
             data = SearchParameter.bathroomSize[row]
            
        }
        
        if pickerView.tag == 3 {
            
             data = SearchParameter.bedSize[row]
        }
        if pickerView.tag == 4 {
             data = SearchParameter.capacity[row]
            
        }
      
        
        
        var label = view as! UILabel!
        if label == nil {
            label = UILabel()
        }
        
        
     
        
        let title = NSAttributedString(string: data!, attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14.0)])
        
        label?.attributedText = title
        label?.textAlignment = .center
        
        if data == SearchParameter.selectBedroom || data == SearchParameter.selectBed || data == SearchParameter.selectBathroom || data == SearchParameter.selectCapacity || data == SearchParameter.selectPeopleNum {
            
            label?.textColor = UIColor.red
            
            
            
        }
        return label!
        
        
    }

    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 0 {
            
             return cities.count
            
        }
        
        
      if   pickerView.tag == 1  {
            
            return SearchParameter.bedroomSize.count
        }
        if   pickerView.tag == 2 {
            
            return SearchParameter.bathroomSize.count
        }
        if pickerView.tag == 3 {
            
            return SearchParameter.bedSize.count
        }
        else {
            
            return SearchParameter.capacity.count
        }

    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
       
        
        if pickerView.tag == 0 {
            
            
       addingFlat.city = cities[row]
            
        }
        
        if pickerView.tag == 1 {
            if SearchParameter.bedroomSize[row] != SearchParameter.selectBedroom {
                addingFlat.bedroomCount = Int(SearchParameter.bedroomSize[row])
                
            }
            
        }
        
        if pickerView.tag == 2 {
            if SearchParameter.bathroomSize[row] != SearchParameter.selectBathroom {
             addingFlat.bathroomCount = Int(SearchParameter.bathroomSize[row])
            }
        }
        
        if pickerView.tag == 3{
            if SearchParameter.bedSize[row] != SearchParameter.selectBed {

            addingFlat.bedCount =  Int(SearchParameter.bedSize[row])
            }
        }
        if pickerView.tag == 4 {
            if SearchParameter.capacity[row] != SearchParameter.selectCapacity {
        
             addingFlat.flatCapacity =  Int(SearchParameter.capacity[row])
            }
        }
       
        
    }

  
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
       
        
        if textView.tag == 0 {
            
            
            addingFlat.address = textView.text
            
        }
        
        else {
            
            addingFlat.flatDescription = textView.text
            
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    

   
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n" {
            flatDescriptionTextView.resignFirstResponder()
            addressTextView.resignFirstResponder()
            return false
        }
        
        return true
    }

   
}





 
