//
//  SettingsVC.swift
//  iFlat
//
//  Created by Alican Yilmaz on 28/12/2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var profileIV: UIImageView!
    var dbuser = FIRUSER()
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        dbuser.getCurrentLoggedIn { (usr) in
            self.dbuser.getUserProfileImg(user: usr!, completion: { (img) in
                let url = URL(string: img!)
                self.profileIV.kf.setImage(with: url)
                self.nameLbl.text = (usr?.name)! + " " + (usr?.surname)!
            })
            
        }
    }


   

}
