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
//    var ImgPickerForCamera = UIImagePickerController()
    
    
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
        
       gender_PickerView.delegate = self
       gender_PickerView.dataSource = self
        
       country_PickerView.dataSource = self
        country_PickerView.delegate = self
        
        myImgPickerController.delegate = self
        myImgPickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
//        ImgPickerForCamera.delegate = self
//        ImgPickerForCamera.sourceType = .camera
        
        
        
    }
    
    
    
    
    
    func validationField() -> Bool {
        
        if imgView_Picker.image != nil && name_TextField.text != nil && lastName_TextField.text != nil && email_TextField.text != nil && password_TextField.text != nil && repeatPassword_TextField.text != nil && (password_TextField.text?.characters.count)! >= 6 && repeatPassword_TextField.text == password_TextField.text  {
            
            return true
        }
            
        else {
            
            return false
        }
    }
    
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        self.user.name = self.name_TextField.text
        self.user.surname = self.lastName_TextField.text
        self.user.email = self.email_TextField.text
        self.user.password = self.password_TextField.text
        self.user.birthDate = self.setDateToString(datePicker: self.birthDate_PickerView)
        self.user.profileImage = UIImage()
        
        if (self.validationField())
            
        {
            
            user.insertUser(user: user) { (error) in
                
                if (error != nil) {
                    print(error)
                }
                    
                else {
                    print(error)
                }
            }
        }
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 0{
            user.Gender  = User.staticGender[row]
        }
        
        if pickerView.tag == 1{
            user.country = User.allCountryList[row]
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
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            
            return User.staticGender[row]
        }
        else {
            return User.allCountryList[row]
        }
    }
    
    
    
    @IBAction func takePhotoTapped(_ sender: UIButton) {
    }
    
    @IBAction func uploadedPhotoTapped(_ sender: UIButton) {
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {

            imgView_Picker.contentMode = .scaleAspectFit
            imgView_Picker.image =  pickedImage
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
    
    
    
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    
    
    
    
    
    
}
