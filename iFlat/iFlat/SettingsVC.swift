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
        
        dbuser.getCurrentLoggedIn { (usr) in
            self.dbuser.getUserProfileImg(user: usr!, completion: { (img) in
                let url = URL(string: img!)
                self.profileIV.kf.setImage(with: url)
                self.nameLbl.text = (usr?.name)! + " " + (usr?.surname)!
            })
            
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
