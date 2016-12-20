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
    private var DB_ENDPOINT:FIRUSERDelegate?
    
   var user = User()
   
    @IBOutlet weak var emailTextField: UITextField!

    @IBOutlet weak var passwordTextField:  UITextField!
    
    

    override func viewDidLoad() {
      
        super.viewDidLoad()
        FIRREF.instance().getRef().child("user_flats/" + "user2").observe(.value, with: { (ss) in
            
            for a in ss.children
            {
                let b = a as! FIRDataSnapshot
                let objdict = b.value as! [String:String]
                print(objdict["name"])
                
            }
        })
   
   
   
        
        
        
}
    
    func dbLoginValidation() -> Bool {
        
        if user.email != nil || user.password != nil {
            
            return true
        }
        
        else{
            
            return  false
    }
    }
    
    func LoginValidation() -> Bool {
        
        if user.email == emailTextField.text || user.password == passwordTextField.text {
            
            return true
        }
        
        else{
            
            return false
        }
    }
    

    @IBAction func LoginButtonTapped(_ sender: UIButton) {
        
        if LoginValidation(){
            if dbLoginValidation(){
                //
            }
            
            //
        }
        
        else{
            
        }
        
    }
    
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
   
    
}
