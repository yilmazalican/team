//
//  RegisterViewController.swift
//  iFlat
//
//  Created by Özge Meva Demiröz on 01/12/2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ShowAlert{

    var user = User()
    var myImgPickerController = UIImagePickerController()
    //var ImgPickerForCamera = UIImagePickerController()




    @IBOutlet weak var takePhotoİmgButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextfield: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var countryPickerView: UIPickerView!
    @IBOutlet weak var birtDarePackerView: UIDatePicker!
    @IBOutlet weak var genderPickerView: UIPickerView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var uploadİmgButton: UIButton!
    @IBOutlet weak var imgView: UIImageView!



    override func viewDidLoad() {
        super.viewDidLoad()





        repeatPasswordTextfield.delegate = self

        passwordTextField.delegate = self

        nameTextField.delegate = self

        lastNameTextField.delegate = self

        genderPickerView.delegate = self
        genderPickerView.dataSource = self

        countryPickerView.dataSource = self
        countryPickerView.delegate = self

        myImgPickerController.delegate = self
        myImgPickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary

//        ImgPickerForCamera.delegate = self
//        ImgPickerForCamera.sourceType = .camera

        








    }




    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

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



    @IBAction func uploadButtonTapped(_ sender: UIButton) {

        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){

           myImgPickerController.allowsEditing = true
            present(myImgPickerController, animated: true, completion: nil)


        }



    }

    @IBAction func takePhotoİmgView(_ sender: UIButton) {


        if UIImagePickerController.isSourceTypeAvailable(.camera){

//            ImgPickerForCamera.allowsEditing = true
//            present(ImgPickerForCamera, animated: true, completion: nil)
//
        }



            }




    @IBAction func nameTextFieldEditingEnd(_ sender: UITextField) {

        user.name = sender.text

    }

    @IBAction func lastNameTextFieldEditingEnd(_ sender: UITextField) {

                user.surname = sender.text
    }

    @IBAction func emailTextFieldEditingEnd(_ sender: UITextField) {

        user.email = sender.text
    }

    @IBAction func passwordTextFieldEditingEnd(_ sender: UITextField) {

        user.password = sender.text
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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


    func passwordCheck()->Bool{

        if user.password == repeatPasswordTextfield.text {

            return true
        }

        else {

            return false
        }
    }


    func  validation()-> Bool {

        if user.name == nil || user.surname == nil || user.email == nil || user.password == nil || user.profileImage == nil
        {
            return false
        }

        else {
            return true
        }

    }


    func textFieldisEmptyCheck()-> Bool {

        if (repeatPasswordTextfield.text?.isEmpty)! || (passwordTextField.text?.isEmpty)! || (nameTextField.text?.isEmpty)! || (emailTextField.text?.isEmpty)! || (lastNameTextField.text?.isEmpty)! {

            return false
        }

        return true
    }


    @IBAction func RegisterButtonTapped(_ sender: UIButton) {

        if validation(){
            if passwordCheck(){
                if textFieldisEmptyCheck(){

                //insert
          }
        }
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



    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        if pickerView.tag == 0{

            user.Gender  = User.staticGender[row]


        }

        if pickerView.tag == 1{


            // user.country
        }



    }
 }
