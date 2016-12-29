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
    
    @IBOutlet weak var flatTitleTextField: UITextField!{
        didSet{
            flatTitleTextField.delegate = self
            
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
    }
    
    @IBAction func flatPriceTitleTextEditing(_ sender: UITextField) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "flatOptionSegue" {
            
            
        }
        
        if segue.identifier == "flatPhotoSegue" {
            
        }
        
    }

}


extension EditFlatViewController:UITextViewDelegate,UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
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

