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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.DB_ENDPOINT = FIRUSER()

        let usr = User(name: "Alicanbaba", surname: "Yilmazbaba4", email: "yilmazbaba19@gmail.com", password: "frozen4192", birthDate: "12/12/12", Gender: "Male")
        
        FIRREF.instance.getRef().child("users").queryOrderedByKey().observe(.childAdded, with: { (snapshot) in
            print("selam")
        })
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
