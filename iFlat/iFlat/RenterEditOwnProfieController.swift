//
//  RenterEditOwnProfieController.swift
//  iFlat
//
//  Created by Tolga Taner on 5.12.2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit

import AVKit
import MobileCoreServices

class RenterEditOwnProfieController: UIViewController {

   
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
   
    var loginUser  = User()
        
        
        var dbFirebase = FIRUSER()
        
    
    var editProfileUser = User()
   
    @IBOutlet weak var nameTextField: UITextField!{
        
        didSet {
            nameTextField.delegate = self
        }
    }
    
    @IBOutlet weak var surnameTextField: UITextField!{
        
        didSet {
        surnameTextField.delegate = self
        }
    }
    
    
    @IBOutlet weak var birthdateDatePicker: UIDatePicker!{
        
        didSet {
            
        }
    }
    
    
    @IBOutlet weak var countyPickerView: UIPickerView!{
        
        didSet {
    countyPickerView.delegate = self
    countyPickerView.dataSource = self
        }
    }
    
    @IBOutlet weak var mailAddressTextField: UITextField!{
        
        didSet {
            mailAddressTextField.delegate = self
        }
    }
    

  
    
    @IBOutlet weak var renterPhotoImageView: UIImageView!
    
    
    
     var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
	
        
  setLoginUser()
      
      
    }
   
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func getPhotoFromLibraryAction(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true, completion: nil)
        }
      

    }
   
    @IBAction func takePhotoAction(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            
            if UIImagePickerController.availableCaptureModes(for: .rear) != nil && UIImagePickerController.availableCaptureModes(for: .front) != nil  {
            
            
                imagePicker.delegate = self
                imagePicker.sourceType = .camera
                imagePicker.allowsEditing = false
                imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: imagePicker.sourceType)!
                present(imagePicker, animated: true, completion: nil)
            }
        }
        
        else {
            
            defaultAlert()
        }
        
    }
   
    @IBAction func birthdatePickerValueChanged(_ sender: UIDatePicker) {
        editProfileUser.birthDate = setDateToString(datePicker: sender)
        
    }
   
    @IBAction func nameTextFieldEditingDidEnd(_ sender: UITextField) {
        editProfileUser.name = sender.text
        
    }
   
    
    @IBAction func surnameTextFieldEditingDidEnd(_ sender: UITextField) {
    editProfileUser.surname = sender.text
    }
    
    @IBAction func mailAddressTextFieldEditingDidEnd(_ sender: UITextField) {
        editProfileUser.email = sender.text
    }
    
    
    @IBAction func editedProfileButtonAction(_ sender: Any) {
        
        
        if self.loginUser.email! != self.editProfileUser.email {
            
            dbFirebase.changeEmail(newEmail: self.editProfileUser.email!, completion: { (err) in
                print(err)
            })
            
            
        }
        
        if self.loginUser.password != self.editProfileUser.password {
            dbFirebase.changePassword(newPassword: loginUser.password!, completion: { (err) in
                print(err)
            })
            
        }
     
        if self.loginUser.profileImage != self.editProfileUser.profileImage{
            
            dbFirebase.changeUserProfileImage(user: loginUser, img: loginUser.profileImage!, completion: { (err) in
                print(err)
            })
        }

    
        
    }
    
    
    func setLoginUser(){
        
        dbFirebase.loginByEmailAndPassword(email: "eposta.alican@gmail.com", password: "123456", completion: { (err) in
            
            print(err)
            
            self.dbFirebase.getCurrentLoggedIn(completion: { (usr) in
                print(usr?.email)
                
                
                self.loginUser = usr as! User
                
                self.editProfileUser = self.loginUser
                
                self.loadingIndicator.stopAnimating()
      	          	
                self.nameTextField.placeholder = self.loginUser.name
                self.surnameTextField.placeholder = self.loginUser.surname
                self.mailAddressTextField.placeholder = self.loginUser.email
                self.renterPhotoImageView.image = self.loginUser.profileImage
                //TODO:SET ALL OBJECT FİELD
                
                
            })
            
        })
    }
    
}


extension RenterEditOwnProfieController : ShowAlert,UIImagePickerControllerDelegate,UINavigationControllerDelegate,DateToString,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate{
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return User.allCountryList[row]
        
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return User.allCountryList.count
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        
        editProfileUser.country = User.allCountryList[row]
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var data:String!
        
        var label = view as! UILabel!
        if label == nil {
            label = UILabel()
        }
        
        
        data = User.allCountryList[row]
        
        let title = NSAttributedString(string: data!, attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14.0)])
        
        label?.attributedText = title
        label?.textAlignment = .center
        
        
        return label!
        
        
    }
    
    

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
    
       let mediaType  = info[UIImagePickerControllerMediaType] as! String
        
       
        if mediaType == (kUTTypeImage as String) {
            
             self.renterPhotoImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
            self.editProfileUser.profileImage = info[UIImagePickerControllerOriginalImage] as? UIImage
            
            
        }
        
        
        picker.dismiss(animated: true, completion: nil)
          }
    
    
}


