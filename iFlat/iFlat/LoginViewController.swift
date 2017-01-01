//
//  LoginViewController.swift
//  iFlat
//
//  Created by Özge Meva Demiröz on 01/12/2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit
import Firebase


class LoginViewController: UIViewController,UITextFieldDelegate,ShowAlert {
    
    var user = User()
    var dbbridge2 = FIRUSER()
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        
    }
    /// This method is check password text field and password text field written by users,
    /// if user do not write in this area,method is return value false.
    /// This methos is return value boolean.
    func validationLoginField() -> Bool {
        
        if !(emailTextField.text?.isEmpty)! && !(passwordTextField.text?.isEmpty)!{
            
            return true
        }
            
        else {
            
            return false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    /// This method provides to send verify email in the user's email.
    /// if user own forgot password,send reset password by the system to users email box.
    /// also this method sends warning message to user.
    @IBAction func forgotPasswordTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Forgot Password", message: "Enter your email", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Enter your email..."
        }
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { [weak alert] (_) in
            if let textField = alert?.textFields![0] {
                self.dbbridge2.forgotPassword(email: (textField.text)!, completion: { (err) in
                    if err != nil
                    {
                        let alert2 = UIAlertController(title: "Error Password", message: "User not found or Badly Formatted Email", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.default) {
                            UIAlertAction in
                        }
                        alert2.addAction(okAction)
                        self.present(alert2, animated: true, completion: nil)
                    }
                    else
                    {
                        let alert3 = UIAlertController(title: "Success", message: "Reset password email sent! Check your email.", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.default) {
                            UIAlertAction in
                        }
                        alert3.addAction(okAction)
                        self.present(alert3, animated: true, completion: nil)

                    }
                })}
        }))
        self.present(alert, animated: true, completion: nil)


    }
    
    
    /// This method compare users information in the firebase and entered users information.
    /// if user information same firebase user information which information password and email,user can enter the system.
    /// Also if user can be login or can not login in this system,method send warning message.
    @IBAction func LoginTapped(_ sender: UIButton) {
        
        if validationLoginField(){
            dbbridge2.loginByEmailAndPassword(email: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (err) in
                if (err != nil) {
                    self.showAlert(title: "Error", message: "Wrong Password")
                }
                else{
                    self.dbbridge2.isUserVerified(completion: { (b) in
                        if b
                        {
                            let viewControllerYouWantToPresent = self.storyboard?.instantiateViewController(withIdentifier: "mainFlow")
                            self.present(viewControllerYouWantToPresent!, animated: true, completion: nil)
                        }
                        else{
                            self.showAlert(title: "Error", message: "Please check your email to verify")
                        }
                    })

                }
            })
            
        }
        else
        {
            self.showAlert(title: "Error", message: "Fill in the blanks!")

        }
        
        
             
        
     
            
          }
            
            
    
    }
            
        
      
        

        
        


