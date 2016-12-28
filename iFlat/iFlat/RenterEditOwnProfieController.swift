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

    
    var cities = [String]()
    
     var  isImageChanged = false
   
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
   
    var loginUser  = User()
    
        
        
        var dbFirebase = FIRUSER()
        
   
   
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
    

  
    
    @IBOutlet weak var renterPhotoImageView: UIImageView!{
        didSet{
         renterPhotoImageView.contentMode = .scaleAspectFill
            renterPhotoImageView.layer.masksToBounds = true
            
         renterPhotoImageView.layer.cornerRadius = renterPhotoImageView.frame.height/2
          
        }
    }
    
    
    
     var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dbFirebase.getCities { (allCities) in
            self.cities = allCities
            
        self.countyPickerView.reloadAllComponents()
        }
        
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
        loginUser.birthDate = setDateToString(datePicker: sender)
        
    }
   
    @IBAction func nameTextFieldEditingDidEnd(_ sender: UITextField) {
        
        
        if sender.text != "" {
         
        loginUser.name = sender.text
        }
        else {
            
           loginUser.name = nameTextField.placeholder
            
        }
        
    }
   
    
    @IBAction func surnameTextFieldEditingDidEnd(_ sender: UITextField) {
       if sender.text != "" {

    loginUser.surname = sender.text
        }
       else {
        loginUser.surname = surnameTextField.placeholder
    }
    }
    
    @IBAction func mailAddressTextFieldEditingDidEnd(_ sender: UITextField) {
       if sender.text != "" {
            
            loginUser.email = sender.text
        }
       else{
        
        loginUser.email = mailAddressTextField.placeholder
        }
       
    }
    
    
    
   
    
    @IBAction func editedProfileButtonAction(_ sender: Any) {
        
     dbFirebase.edit(newUsr: self.loginUser) { (err) in
        print(err)
        }
        
       
        
        
            
        
    
//            dbFirebase.changePassword(newPassword: loginUser.password!, completion: { (err) in
//                print(err)
//            })
        
     
        if   isImageChanged  {
            
            dbFirebase.changeUserProfileImage(user: loginUser, img: loginUser.profileImage!, completion: { (err) in
                print(err)
                
                 self.isImageChanged = false
            })
            
           
        }
        

        
    }
    
    
  private func setLoginUser(){
        
        dbFirebase.loginByEmailAndPassword(email: "tolga@gmail.com", password: "123456", completion: { (err) in
            
            print(err)
            
            self.dbFirebase.getCurrentLoggedIn(completion: { (usr) in
                print(usr?.email)
                
                
                self.loginUser = usr as! User
                
                
                self.nameTextField.placeholder = self.loginUser.name
                self.surnameTextField.placeholder = self.loginUser.surname
                self.mailAddressTextField.placeholder = self.loginUser.email
                self.birthdateDatePicker.setDate(Date(dateString:self.loginUser.birthDate!), animated: false)
                
                      self.dbFirebase.getUserProfileImg(user: self.loginUser, completion: { (userImageUrl) in
                        
                       
                        self.urlToImage(url: userImageUrl!, completionHandler: { (image) in
                           self.loginUser.profileImage = image
                            self.renterPhotoImageView.image = image

                            self.loadingIndicator.stopAnimating()
                            
                        })
                      })
                              
                
            })
            
        })
    }
    
}


extension RenterEditOwnProfieController : ShowAlert,UIImagePickerControllerDelegate,UINavigationControllerDelegate,DateToString,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate,imageMaker{
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return cities[row]
        
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return cities.count
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
       
        
        loginUser.country = cities[row]
        
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
        
        
        data = cities[row]
        
        let title = NSAttributedString(string: data!, attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14.0)])
        
        label?.attributedText = title
        label?.textAlignment = .center
        
        
        return label!
        
        
    }
    
    

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
         self.isImageChanged = true
            
            self.renterPhotoImageView.image = image
            
         self.loginUser.profileImage = image
        }
        
            
        
        
        
        picker.dismiss(animated: true, completion: nil)
          }
    
    
}


