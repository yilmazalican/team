//
//  EditFlatViewController.swift
//  iFlat
//
//  Created by Tolga Taner on 29.12.2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit

class EditFlatViewController: UIViewController {

    var editingFlat = Flat()
    var firebase = FIRFlat()
    
    var oldCity:String = ""
   
    @IBOutlet weak var flatPhotoButton: UIButton!{
        didSet{
            flatPhotoButton.isHidden = true 
        }
    }
    @IBOutlet weak var flatTitleTextField: UITextField!{
        didSet{
            flatTitleTextField.delegate = self
            flatTitleTextField.placeholder = editingFlat.title
            
        }
        
    }
    
    @IBOutlet weak var addressTextView: UITextView!{
        didSet{
            addressTextView.delegate = self
            addressTextView.layer.cornerRadius = 10
            addressTextView.delegate = self
            

        }
    }
    
    @IBOutlet weak var flatPriceTextField: UITextField!{
        
        didSet{
            
            flatPriceTextField.delegate = self
        
            if  let  price = editingFlat.price {
                
                 flatPriceTextField.placeholder =  String(Int(price))
            }
            
        
        }
    }
    @IBOutlet weak var flatDescriptionTextView: UITextView!{
        didSet{
            
            flatDescriptionTextView.delegate = self
            flatDescriptionTextView.layer.cornerRadius = 10
            flatDescriptionTextView.delegate = self
            
        }
    }
    
    
    @IBAction func flatTitleTextEditing(_ sender: UITextField) {
        
        
        
        if sender.text != "" {
            
            editingFlat.title = sender.text
        }
        else {
            
            editingFlat.title = sender.placeholder
            
        }

    }
    
    @IBAction func flatPriceTitleTextEditing(_ sender: UITextField) {
        
        if sender.text != "" {
            
            editingFlat.title = sender.text
        }
        else {
            
            editingFlat.price = Double(sender.placeholder!)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        oldCity = editingFlat.city!
        
        addressTextView.text = editingFlat.address
        flatDescriptionTextView.text = editingFlat.flatDescription

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "flatPhotoSegue" {
            
            if let controller :EditPhotoViewController = segue.destination as? EditPhotoViewController {
             
                controller.flat = editingFlat
            
        }
        }
        if segue.identifier == "flatOptionSegue" {
            
            
            
            if let controller :EditFlatOptionViewController = segue.destination as? EditFlatOptionViewController {
                controller.editingFlatOptions = editingFlat
             
                
            }

        }
        
    }
    @IBAction func editFlatActionButton(_ sender: Any) {
        firebase.edit(oldcity: oldCity, newFlt: editingFlat) { (err) in
            print(err)
        }
    }

}


extension EditFlatViewController:UITextViewDelegate,UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.tag == 0 {
            
           editingFlat.flatDescription = textView.text
            
        }
        
        else {
            editingFlat.address = textView.text
            
        }
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

