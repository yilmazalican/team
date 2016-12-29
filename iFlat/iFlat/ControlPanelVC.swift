//
//  ViewController.swift
//  iFlat
//
//  Created by Alican Yilmaz on 24/11/2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import Kingfisher


class ControlPanelVC: UITableViewController, ShowAlert {
    var dbUser = FIRUSER()


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 3{
            UIApplication.shared.open(URL(string:"mailto:\"support@iflat.com")!, options: [:], completionHandler: nil)
        }
        if indexPath.row == 4{
                    let alert = UIAlertController(title: "Confirmation", message: "Are you sure?", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
                    alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
                        self.dbUser.logout(completion: { (err) in
                            if err == nil{
                                self.dismiss(animated: true, completion: nil)
                            }
                        })
                    }))
                    self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 }

}



