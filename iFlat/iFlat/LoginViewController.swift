//
//  LoginViewController.swift
//  iFlat
//
//  Created by Özge Meva Demiröz on 01/12/2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    var user = User()
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
    }
    
    func validationLoginField() -> Bool {
        
        if emailTextField.text != nil && passwordTextField.text != nil {
            
            return true
        }
            
        else {
            
            return false
        }
    }
    
    @IBAction func LoginTapped(_ sender: UIButton) {
        
        self.user.email = emailTextField.text
        self.user.password = passwordTextField.text
        
        if (self.validationLoginField()) {
            
            
            
            
           
            
            
            
            
            
            
        }
            
        
         }
        
       }
        
        


