//
//  RegisterViewController.swift
//  iFlat
//
//  Created by Özge Meva Demiröz on 01/12/2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit


class RegisterViewController: UIViewController,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ShowAlert,DateToString{
    
    var user = User()
    var myImgPickerController = UIImagePickerController()
    //var ImgPickerForCamera = UIImagePickerController()
    
    
    @IBOutlet weak var imgView_Picker: UIImageView!
    
    @IBOutlet weak var name_TextField: UITextField!
    
    @IBOutlet weak var lastName_TextField: UITextField!
    
    @IBOutlet weak var email_TextField: UITextField!
    
    @IBOutlet weak var gender_PickerView: UIPickerView!
    
    @IBOutlet weak var birthDate_PickerView: UIDatePicker!
    
    @IBOutlet weak var country_PickerView: UIPickerView!
    
    @IBOutlet weak var password_TextField: UITextField!
    
    @IBOutlet weak var repeatPassword_TextField: UITextField!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        genderPickerView.delegate = self
        genderPickerView.dataSource = self
        
        countryPickerView.dataSource = self
        countryPickerView.delegate = self
        
        myImgPickerController.delegate = self
        myImgPickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        // ImgPickerForCamera.delegate = self
        // ImgPickerForCamera.sourceType = .camera
        
        
        
        
        
        
        
        
        
        
    }
    
    
    
    
    
    func validationField() -> Bool {
        
        if imgView_Picker.image != nil || name_TextField.text != nil || lastName_TextField.text != nil || email_TextField.text != nil || password_TextField.text != nil || repeatPassword_TextField.text != nil && password_TextField.text?.characters.count >= 6  {
            
            return true
        }
            
        else {
            
            return false
        }
    }
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        
        user.DB_ENDPOINT.insert(usr: user) { (error) in
            
            if error != nil || self.!validationField(){
                
            }
                
            else {
                let profileImg = self.imgView_Picker.image
                self.user = User(name: self.name_TextField.text, surname: self.lastName_TextField.text, email: self.email_TextField.text, password: self.password_TextField.text, birthDate:DateToString(birthDate_PickerView), Gender:self.gender_PickerView.va, profileImage: UIImage)
            }
            
        }
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 0{
            user.Gender  = User.staticGender[row]
        }
        
        if pickerView.tag == 1{
            //user.Gender =
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 0{
            return User.staticGender.count
        }
        else {
            return User.allCountryList.count
        }
    }
    
    
    
    @IBAction func takePhotoTapped(_ sender: UIButton) {
    }
    
    @IBAction func uploadedPhotoTapped(_ sender: UIButton) {
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            imgView.contentMode = .scaleAspectFit
            imgView.image =  pickedImage
            user.profileImage = pickedImage
            
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        
        
    }
    
    
    
    
    
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            
            return User.staticGender[row]
        }
        else {
            return User.allCountryList[row]
        }
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    
    
    
    
    
    
}
