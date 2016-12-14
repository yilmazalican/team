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
        let img = UIImage()
        let arr = [img]
        let usr = User()
        let flt = Flat(title: "dsadsa", flatDescription: "dsadas", city: "ist", address: "dsadsa", flatCapacity: 2, bathRoomCount: 2, bedcount: 2, pool: true, internet: true, cooling: true, heating: true, tv: true, washingMachine: true, elevator: true, parking: true, smoking: true, gateKeeper: true, price: 3, deleted: true, images:arr , bedroomCount: 3)

        usr.insertFlat(flt: flt) { (dsadsa) in
            print(dsadsa)
        }
        
        
        
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
